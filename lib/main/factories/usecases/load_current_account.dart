import 'package:flutter_clean/data/features/features.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/main/factories/factories.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(
    fetchSecureCacheStorage: makeLocalStorageAdapter(),
  );
}
