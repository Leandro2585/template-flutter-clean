import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_clean/domain/entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> execute(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List get props => [name, email, password, confirmPassword];

  const AddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
  });
}
