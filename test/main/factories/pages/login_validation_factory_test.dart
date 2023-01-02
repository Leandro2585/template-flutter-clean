import 'package:test/test.dart';

import 'package:flutter_clean/main/factories/factories.dart';
import 'package:flutter_clean/application/validators/validators.dart';

void main() {
  test('should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
    ]);
  });
}
