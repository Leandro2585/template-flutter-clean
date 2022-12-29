import 'package:test/test.dart';
import 'package:flutter_clean/application/protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

  @override
  String validate(String value) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
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

  test('should return error if email is invalid', () {
    expect(sut.validate('leo.real2585'), 'Campo inválido');
  });
}
