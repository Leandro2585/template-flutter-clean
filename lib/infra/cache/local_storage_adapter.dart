import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_clean/data/cache/cache.dart';

class LocalStorageAdapter implements SaveCacheStorage, FetchSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({@required this.secureStorage});

  @override
  Future<void> save({@required String key, @required String value}) async {}

  @override
  Future<void> saveSecure({
    @required String key,
    @required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String> fetchSecure(String key) async {
    return await secureStorage.read(key: key);
  }
}
