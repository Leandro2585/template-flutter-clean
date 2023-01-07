import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';

abstract class SaveCacheStorage {
  Future<void> save({String key, String value});
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveCacheStorageSpy extends Mock implements SaveCacheStorage {}

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveCacheStorage saveCacheStorage;

  LocalSaveCurrentAccount({@required this.saveCacheStorage});
  @override
  Future<void> save(AccountEntity account) async {
    await saveCacheStorage.saveSecure(key: 'token', value: account.token);
  }
}

void main() {
  test('should call SaveCacheStorage with correct values', () async {
    final cacheStorage = SaveCacheStorageSpy();
    final sut = LocalSaveCurrentAccount(saveCacheStorage: cacheStorage);
    final account = AccountEntity(faker.guid.guid());

    await sut.save(account);

    verify(cacheStorage.saveSecure(key: 'token', value: account.token));
  });
}
