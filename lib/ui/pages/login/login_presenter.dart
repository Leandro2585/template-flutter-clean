import 'package:flutter_clean/ui/exceptions/exceptions.dart';

abstract class LoginPresenter {
  Stream<UIExceptions> get emailErrorStream;
  Stream<UIExceptions> get passwordErrorStream;
  Stream<UIExceptions> get mainErrorStream;
  Stream<String> get navigateToStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  Future<void> auth();
  void validateEmail(String email);
  void validatePassword(String password);
  void dispose();
}
