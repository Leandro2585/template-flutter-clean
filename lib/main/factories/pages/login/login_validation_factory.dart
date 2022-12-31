import 'package:flutter_clean/application/protocols/protocols.dart';
import 'package:flutter_clean/application/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ]);
}
