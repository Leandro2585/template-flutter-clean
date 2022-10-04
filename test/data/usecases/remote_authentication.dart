import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({ @required this.httpClient, @required this.url });

  Future<void> execute() async {
    await httpClient.request(url: url, method: 'post');
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
  test('should call HttpClient with correct URL', () async {
    final url = faker.internet.httpUrl();
    final httpClient = HttpClientSpy();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    
    await sut.execute();

    verify(httpClient.request(url: url, method: 'post'));
  });
}