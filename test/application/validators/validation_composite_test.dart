import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/application/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({@required String field, @required String value}) {
    return null;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  ValidationComposite sut;

  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    sut = ValidationComposite([validation1, validation2]);
  });

  test('should return null if all validations returns null or empty', () {
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate(any)).thenReturn(null);
    when(validation2.field).thenReturn('any_field');
    when(validation2.validate(any)).thenReturn('');
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
