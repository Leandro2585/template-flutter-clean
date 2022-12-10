import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/domain/helpers/domain_error.dart';
import 'package:flutter_clean/domain/usecases/authentication.dart';
import 'package:meta/meta.dart';
class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({ @required this.httpClient, @required this.url });

  Future<void> execute(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      await httpClient.request(url: url, method: 'post', body: body);
    } on HttpError {
      throw DomainError.unexpected;
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
