import 'package:flutter_clean/application/validators/validators.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/application/protocols/protocols.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  ValidationComposite sut;

  void mockValidation1(ValidationError error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(ValidationError error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    when(validation1.field).thenReturn('other_field');
    when(validation2.field).thenReturn('any_field');
    mockValidation1(null);
    sut = ValidationComposite([validation1, validation2]);
  });

  test('should return null if all validations returns null or empty', () {
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('should return the first error', () {
    mockValidation1(ValidationError.requiredField);
    mockValidation2(ValidationError.invalidField);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, ValidationError.requiredField);
  });
}
