import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/application/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({@required String field, @required String value}) {
    String error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(value);
      if (error == '') {
        return null;
      } else if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return error;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  ValidationComposite sut;

  void mockValidation1(String error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(String error) {
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
    mockValidation2('');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('should return the first error', () {
    mockValidation1('error_1');
    mockValidation2('error_2');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_2');
  });
}
