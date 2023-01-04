import 'package:flutter_clean/domain/exceptions/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/application/protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  String _email;
  String _password;

  final _emailError = RxString(null);
  final _passwordError = RxString(null);
  final _mainError = RxString(null);
  final _isFormValid = false.obs;
  final _isLoading = false.obs;

  @override
  Stream<String> get emailErrorStream => _emailError.stream;
  @override
  Stream<String> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<String> get mainErrorStream => _mainError.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
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
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password);
    _validateForm();
  }

  @override
  Future<void> auth() async {
    _isLoading.value = true;
    _validateForm();
    try {
      await authentication.execute(
        AuthenticationParams(email: _email, password: _password),
      );
    } on DomainError catch (error) {
      _mainError.value = error.description;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {}
}
