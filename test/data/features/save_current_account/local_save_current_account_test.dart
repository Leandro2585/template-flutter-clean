import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/data/cache/cache.dart';
import 'package:flutter_clean/data/features/features.dart';
import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';

class SaveCacheStorageSpy extends Mock implements SaveCacheStorage {}

void main() {
  SaveCacheStorageSpy cacheStorage;
  AccountEntity account;
  LocalSaveCurrentAccount sut;

  setUp(() {
    cacheStorage = SaveCacheStorageSpy();
    account = AccountEntity(faker.guid.guid());
    sut = LocalSaveCurrentAccount(saveCacheStorage: cacheStorage);
  });
  test('should call SaveCacheStorage with correct values', () async {
    await sut.save(account);

    verify(cacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('should throw UnexpectedError if SaveCacheStorage throws', () async {
    when(cacheStorage.saveSecure(
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
