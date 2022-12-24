import 'package:flutter/material.dart';

import 'package:flutter_clean/ui/components/components.dart';
import 'package:flutter_clean/ui/pages/pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({this.presenter, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text(
                              'Aguarde ...',
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ],
                  );
                });
          }
        });
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const LoginHeader(),
              const Headline1(text: 'Login'),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<String>(
                          stream: presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                                icon: Icon(
                                  Icons.email,
                                  color: theme.primaryColorLight,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter.validateEmail,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  errorText: snapshot.data?.isEmpty == true
                                      ? null
                                      : snapshot.data,
                                  icon: Icon(
                                    Icons.lock,
                                    color: theme.primaryColorLight,
                                  ),
                                ),
                                obscureText: true,
                                onChanged: presenter.validatePassword,
                              );
                            }),
                      ),
                      StreamBuilder<bool>(
                          stream: presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed:
                                  snapshot.data == true ? presenter.auth : null,
                              child: Text('Entrar'.toUpperCase()),
                            );
                          }),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person),
                          label: const Text('Criar Conta')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
