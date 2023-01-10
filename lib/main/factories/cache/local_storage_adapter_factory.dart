import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_clean/infra/cache/cache.dart';

LocalStorageAdapter makeLocalStorageAdapter() {
  const secureStorage = FlutterSecureStorage();
  return LocalStorageAdapter(secureStorage: secureStorage);
}
