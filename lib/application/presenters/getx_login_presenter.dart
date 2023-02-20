import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';
import 'package:flutter_clean/application/protocols/protocols.dart';
import 'package:flutter_clean/ui/exceptions/exceptions.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;

  final _emailError = Rx<UIExceptions>(null);
  final _passwordError = Rx<UIExceptions>(null);
  final _mainError = Rx<UIExceptions>(null);
  final _isFormValid = false.obs;
  final _isLoading = false.obs;
  final _navigateTo = RxString(null);

  @override
  Stream<UIExceptions> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIExceptions> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UIExceptions> get mainErrorStream => _mainError.stream;
  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount,
  });

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  UIExceptions _validateField({String field, String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIExceptions.invalidField;
      case ValidationError.requiredField:
        return UIExceptions.requiredField;
      default:
        return null;
    }
  }

  @override
  Future<void> auth() async {
    _isLoading.value = true;
    _validateForm();
    try {
      final account = await authentication
          .execute(AuthenticationParams(email: _email, password: _password));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/home';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          _mainError.value = UIExceptions.invalidCredentials;
          break;
        default:
          _mainError.value = UIExceptions.unexpected;
          break;
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {}
}
