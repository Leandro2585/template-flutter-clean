import 'package:flutter_clean/data/models/models.dart';
import 'package:meta/meta.dart';

import 'package:flutter_clean/data/http/http.dart';
import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';
import 'package:flutter_clean/domain/exceptions/exceptions.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({@required this.httpClient, @required this.url});

  @override
  Future<AccountEntity> execute(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.emailInUse
          : DomainError.unexpected;
    }
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RemoteAddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) =>
      RemoteAddAccountParams(
        name: params.name,
        email: params.email,
        password: params.password,
        confirmPassword: params.confirmPassword,
      );

  Map toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
