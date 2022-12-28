import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_clean/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> execute(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String password;

  @override
  List get props => [email, password];

  const AuthenticationParams({@required this.email, @required this.password});
}
