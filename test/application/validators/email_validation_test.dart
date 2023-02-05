import 'package:test/test.dart';

import 'package:flutter_clean/application/protocols/protocols.dart';
import 'package:flutter_clean/application/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = const EmailValidation('any_field');
  });

  test('should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('should return null if email is valid', () {
    expect(sut.validate('leo.real2585@gmail.com'), null);
  });

  test('should return error if email is invalid', () {
    expect(sut.validate('leo.real2585'), ValidationError.invalidField);
  });
}
