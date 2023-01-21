import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/entities/entities.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity> load() async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    return AccountEntity(token: token);
  }
}

abstract class FetchSecureCacheStorage {
  Future<String> fetchSecure(String key) {}
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  String token;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  LocalLoadCurrentAccount sut;

  void mockFetchSecure() {
    when(fetchSecureCacheStorage.fetchSecure(any))
        .thenAnswer((_) async => token);
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
}
