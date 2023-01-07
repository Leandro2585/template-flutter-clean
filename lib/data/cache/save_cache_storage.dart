import 'package:meta/meta.dart';

abstract class SaveCacheStorage {
  Future<void> save({String key, String value});
  Future<void> saveSecure({@required String key, @required String value});
}
