import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/data/features/features.dart';
import 'package:flutter_clean/domain/helpers/helpers.dart';
import 'package:flutter_clean/domain/usecases/authentication.dart';

import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  AuthenticationParams params;
  RemoteAuthentication sut;
  HttpClientSpy httpClient; 
  String url;

  setUp(() {
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('should call HttpClient with correct values', () async {
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    await sut.execute(params);

    verify(httpClient.request(url: url, method: 'post', body: { 'email': params.email, 'password': params.password }));
  });

  test('should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.badRequest);

    final future = sut.execute(params);
  
    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient returns 404', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.notFound);

    final future = sut.execute(params);
  
    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient returns 500', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.serverError);

    final future = sut.execute(params);
  
    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw InvalidCredentialsError if HttpClient returns 401', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.unauthorized);
    
    final future = sut.execute(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });
}