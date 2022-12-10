import 'package:meta/meta.dart';

import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/helpers/domain_error.dart';
import 'package:flutter_clean/domain/usecases/authentication.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({ @required this.httpClient, @required this.url });

  Future<AccountEntity> execute(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final response = await httpClient.request(url: url, method: 'post', body: body);
      return AccountEntity.fromJson(response);
    } on HttpError catch(error) {
      throw error == HttpError.unauthorized 
        ? DomainError.invalidCredentials 
        : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    @required this.email,
    @required this.password
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) => RemoteAuthenticationParams(email: params.email, password: params.password);

  Map toJson() => {'email': email, 'password': password};
}
