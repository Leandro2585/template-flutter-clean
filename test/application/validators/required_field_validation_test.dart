import 'package:test/test.dart';

import 'package:flutter_clean/application/protocols/protocols.dart';
import 'package:flutter_clean/application/validators/validators.dart';

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = const RequiredFieldValidation('any_field');
  });
  test('should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('should return error if value is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('should return error if value is null', () {
    expect(sut.validate(null), ValidationError.requiredField);
  });
}
