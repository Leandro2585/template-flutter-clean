import 'package:flutter_clean/application/protocols/protocols.dart';
import 'package:flutter_clean/application/validators/email_validation.dart';
import 'package:flutter_clean/application/validators/required_field_validation.dart';

class ValidationBuilder {
  static ValidationBuilder _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._();

  static ValidationBuilder field(String fieldName) {
    _instance = ValidationBuilder._();
    _instance.fieldName = fieldName;
    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }  

  List<FieldValidation> build() => validations;
}
