import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/data/usecases/usecases.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;
  
  setup(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);  
  });

  test('should call HttpClient with correct URL', () async {
    final input = AuthenticationInput(email: faker.internet.email(), password: faker.internet.password());
    await sut.execute(input);

    verify(httpClient.request(url: url, method: 'post', body: {'email': input.email, 'password': input.password}));
  });
}