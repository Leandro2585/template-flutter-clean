import 'package:faker/faker.dart';
import 'package:flutter_clean/domain/usecases/authentication.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({ required this.httpClient, required this.url });

  Future<void> execute(AuthenticationParams params) async {
    final body = {'email': params.email, 'password': params.password};
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient {
  Future<void>? request({
    required String url,
    required String method,
    Map body
  });
}

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