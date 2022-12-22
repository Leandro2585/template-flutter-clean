import 'package:flutter/material.dart';

import 'package:flutter_clean/ui/components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: theme.primaryColorLight,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(
                            Icons.lock,
                            color: theme.primaryColorLight,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: null,
                      child: Text('Entrar'.toUpperCase()),
                    ),
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
      ),
    );
  }
}
