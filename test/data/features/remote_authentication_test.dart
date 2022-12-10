import 'package:flutter_clean/data/features/features.dart';
import 'package:flutter_clean/data/http/http.dart';

import 'package:faker/faker.dart';
import 'package:flutter_clean/domain/usecases/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient; 
  late String url;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('should call HttpClient with correct values', () async {
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    await sut.execute(params);

    verify(httpClient.request(url: url, method: 'post', body: { 'email': params.email, 'password': params.password }));
  });
}