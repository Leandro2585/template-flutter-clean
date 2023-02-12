import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/data/features/features.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAddAccount sut;
  HttpClientSpy httpClient;
  String url;
  AddAccountParams params;

  Map mockValidData() =>
      {'accessToken': faker.guid.guid(), 'name': faker.person.name()};

  PostExpectation _mockRequest() => when(
        httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
          body: anyNamed('body'),
        ),
      );

  void mockHttpResponse(Map data) {
    _mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    _mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    params = AddAccountParams(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      confirmPassword: faker.internet.password(),
    );
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
    mockHttpResponse(mockValidData());
  });

  test('should call HttpClient with correct values', () async {
    await sut.execute(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'confirmPassword': params.confirmPassword,
      },
    ));
  });

  test('should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.execute(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.execute(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.execute(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw EmailInUseError if HttpClient returns 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.execute(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('should return an Account if HttpClient returns 200', () async {
    final validData = mockValidData();
    mockHttpResponse(validData);

    final account = await sut.execute(params);

    expect(account.token, validData['accessToken']);
  });

  test(
      'should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpResponse({'invalid_key': 'invalid_value'});

    final future = sut.execute(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
