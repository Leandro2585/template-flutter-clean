import 'package:flutter_clean/data/cache/cache.dart';
import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';

import 'package:meta/meta.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
