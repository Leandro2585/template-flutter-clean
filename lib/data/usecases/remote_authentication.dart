import 'package:meta/meta.dart';

import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/domain/usecases/authentication.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({ @required this.httpClient, @required this.url });

  Future<void> execute(AuthenticationInput input) async {
    await httpClient.request(url: url, method: 'post', body: input.toJson());
  }
}