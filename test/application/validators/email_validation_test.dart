import 'package:test/test.dart';
import 'package:flutter_clean/application/protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

  @override
  String validate(String value) {
    return null;
  }
}

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
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
}
