import 'package:meta/meta.dart';

import 'package:flutter_clean/data/cache/cache.dart';
import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveCacheStorage saveCacheStorage;

  LocalSaveCurrentAccount({@required this.saveCacheStorage});
  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
