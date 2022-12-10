import 'package:meta/meta.dart';

import 'package:flutter_clean/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> execute({
    @required String email, 
    @required String password
  });
}