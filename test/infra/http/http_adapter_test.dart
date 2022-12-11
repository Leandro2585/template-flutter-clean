import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean/data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    @required String url,
    @required String method,
    Map body
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    return jsonDecode(response.body);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  String url;
  ClientSpy client;
  HttpAdapter sut; 

  setUp(() {
    url = faker.internet.httpUrl();
    client = ClientSpy();
    sut = HttpAdapter(client);
  });

  group('POST', () {
    test('should call post with correct values', () async {
      when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(
        Uri.parse(url), 
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: '{"any_key":"any_value"}'
      ));
    });

    test('should call post without body', () async {
      when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      await sut.request(url: url, method: 'post');

      verify(client.post(
        any,
        headers: anyNamed('headers')
      ));
    });

    test('should return data if post returns 200', () async {
      when(client.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      when(client.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });
  });
}