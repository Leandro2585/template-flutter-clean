import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';

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
    try {
      await saveCacheStorage.saveSecure(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
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

  test('should throw UnexpectedError if SaveCacheStorage throws', () async {
    final cacheStorage = SaveCacheStorageSpy();
    final sut = LocalSaveCurrentAccount(saveCacheStorage: cacheStorage);
    final account = AccountEntity(faker.guid.guid());
    when(cacheStorage.saveSecure(
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
