import 'dart:async';

import 'package:flutter_clean/ui/exceptions/exceptions.dart';
import 'package:meta/meta.dart';

import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';
import 'package:flutter_clean/application/protocols/protocols.dart';

class LoginState {
  String email;
  String password;
  UIExceptions emailError;
  UIExceptions passwordError;
  UIExceptions mainError;
  String navigateTo;
  bool isLoading = false;
  bool get isFormValidStream =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  var _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  @override
  Stream<UIExceptions> get emailErrorStream =>
      _controller?.stream?.map((state) => state.emailError)?.distinct();

  @override
  Stream<UIExceptions> get passwordErrorStream =>
      _controller?.stream?.map((state) => state.passwordError)?.distinct();

  @override
  Stream<UIExceptions> get mainErrorStream =>
      _controller?.stream?.map((state) => state.mainError)?.distinct();

  @override
  Stream<String> get navigateToStream =>
      _controller?.stream?.map((state) => state.navigateTo)?.distinct();
  @override
  Stream<bool> get isLoadingStream =>
      _controller?.stream?.map((state) => state.isLoading)?.distinct();

  @override
  Stream<bool> get isFormValidStream =>
      _controller?.stream?.map((state) => state.isFormValidStream)?.distinct();

  StreamLoginPresenter({
    @required this.validation,
    @required this.authentication,
  });

  void _update() => _controller?.add(_state);

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = _validateField(field: 'email', value: email);
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = _validateField(field: 'password', value: password);
    _update();
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
    _state.isLoading = true;
    _update();
    try {
      await authentication.execute(
        AuthenticationParams(email: _state.email, password: _state.password),
      );
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          _state.mainError = UIExceptions.invalidCredentials;
          break;
        default:
          _state.mainError = UIExceptions.unexpected;
          break;
      }
    } finally {
      _state.isLoading = false;
      _update();
    }
  }

  @override
  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
