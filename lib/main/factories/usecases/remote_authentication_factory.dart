import 'package:flutter_clean/data/features/features.dart';
import 'package:flutter_clean/main/factories/http/http.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';

Authentication makeRemoteAuthentication() {
  final url = makeApiUrl('login');

  return RemoteAuthentication(httpClient: makeHttpClient(), url: url);
}
