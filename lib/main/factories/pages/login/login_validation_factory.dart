import 'package:flutter_clean/application/protocols/protocols.dart';
import 'package:flutter_clean/application/validators/validators.dart';
import 'package:flutter_clean/main/builders/validation_builder.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build()
  ];
}
