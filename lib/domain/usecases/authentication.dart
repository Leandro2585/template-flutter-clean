import 'package:meta/meta.dart';

import 'package:flutter_clean/domain/entities/entities.dart';
abstract class Authentication {
  Future<AccountEntity> execute(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String password;

  AuthenticationParams({
    @required this.email,
    @required this.password
  });
}