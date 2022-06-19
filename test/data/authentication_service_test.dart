import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template_flutter_clean/data/features/authentication_service.dart';
import 'package:template_flutter_clean/data/protocols/repositories/index.dart';
import 'package:template_flutter_clean/domain/entities/index.dart';
import 'package:template_flutter_clean/domain/errors/index.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  UserRepository _userRepository = UserRepositoryMock();
  AuthenticationService _authService = AuthenticationService(_userRepository);
  var mockedUser = User(name: 'any_name', email: 'any_mail@mail.com', avatarURL: 'any_url', bornDate: DateTime.now());

  test('should accomplish authentication', () async {
    when(() => _userRepository.auth(email: 'any_mail@mail.com', password: 'any_password'))
      .thenAnswer((_) async => Right(mockedUser));
    var result = await _authService.call(AuthencationServiceInput(email: 'any_mail@mail.com', password: 'any_password'));

    expect(result, isA<Right>());
    expect(result, Right(mockedUser));
    verify(() => _userRepository.auth(email: 'any_mail@mail.com', password: 'any_password')).called(1);
    verifyNoMoreInteractions(_userRepository);
  });

  test('should get wrong password error when authentication fails', () async {
    when(() => _userRepository.auth(email: 'any_mail@mail.com', password: 'invalid_password'))
      .thenAnswer((_) async => Left(WrongPassword()));
    
    var result = await _authService.call(AuthencationServiceInput(email: 'any_mail@mail.com', password: 'invalid_password'));
    expect(result, isA<Left>());
    expect(result, const Left(WrongPassword));
    verify(() => _userRepository.auth(email: 'any_mail@mail.com', password: 'any_password')).called(1);
    verifyNoMoreInteractions(_userRepository);
  });
}
