import 'package:flutter_clean/domain/usecases/authentication.dart';
import 'package:meta/meta.dart';

import 'package:flutter_clean/data/http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({ @required this.httpClient, @required this.url });

  Future<void> execute(AuthenticationInput input) async {
    final body = RemoteAuthenticationInput.fromDomain(input).toJson();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

class RemoteAuthenticationInput {
  final String email;
  final String password;

  RemoteAuthenticationInput({
    required this.email, 
    required this.password
  });

  factory RemoteAuthenticationInput.fromDomain(AuthenticationInput input) => 
    RemoteAuthenticationInput(email: input.email, password: input.password);

  Map toJson() => {'email': email, 'password': password};
}