
import 'package:flutter_clean/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> execute(AuthenticationInput input);
}

class AuthenticationInput {
  final String email;
  final String password;

  AuthenticationInput({
    required this.email, 
    required this.password
  });

  Map toJson() => {'email': email, 'password': password}
}