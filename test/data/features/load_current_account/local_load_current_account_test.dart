import 'package:faker/faker.dart';
import 'package:flutter_clean/data/features/features.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/data/cache/cache.dart';
import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  String token;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  LocalLoadCurrentAccount sut;

  PostExpectation mockFetchSecureCall() =>
      when(fetchSecureCacheStorage.fetchSecure(any));

  void mockFetchSecure() {
    mockFetchSecureCall().thenAnswer((_) async => token);
  }

  void mockFetchSecureError() {
    mockFetchSecureCall().thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
    );
    token = faker.guid.guid();
    mockFetchSecure();
  });

  test('should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token: token));
  });

  test('shoul throw UnexpectedError if FetchSecureCacheStorage throws',
      () async {
    mockFetchSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
