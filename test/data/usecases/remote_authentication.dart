import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:flutter_clean/domain/usecases/usecases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({ @required this.httpClient, @required this.url });

  Future<void> execute(AuthenticationInput input) async {
    final body = { 'email': input.email, 'password': input.password };
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient {
  Future<void> request({
    @required String url,
    @required String method
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;
  
  setup(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);  
  })

  test('should call HttpClient with correct URL', () async {
    final input = AuthenticationInput(email: faker.internet.email(), password: faker.internet.password());
    await sut.execute(input);

    verify(httpClient.request(url: url, method: 'post', body: {'email': input.email, 'password': input.password}));
  });
}