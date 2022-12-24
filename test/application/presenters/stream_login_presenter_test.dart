import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/application/presenters/presenters.dart';
import 'package:flutter_clean/application/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  String email;
  ValidationSpy validation;
  StreamLoginPresenter sut;

  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    email = faker.internet.email();
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    mockValidation();
  });

  test('should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('should emit email error if validation fails', () {
    mockValidation(value: 'error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
