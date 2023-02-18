import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean/ui/i18n/i18n.dart';
import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:flutter_clean/ui/components/components.dart';
import 'package:flutter_clean/ui/exceptions/exceptions.dart';
import 'package:flutter_clean/ui/pages/login/components/components.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({Key key, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 244, 255, 1),
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });
        presenter.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error.description);
          }
        });
        presenter.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page);
          }
        });
        return GestureDetector(
          onTap: _hideKeyboard,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const LoginHeader(),
                Container(
                    height: MediaQuery.of(context).size.height - 240,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 32,
                          blurStyle: BlurStyle.outer,
                          offset: Offset(0, 2),
                          color: Color.fromRGBO(82, 130, 255, 0.09),
                        )
                      ],
                      color: theme.backgroundColor,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Headline1(
                            title: 'Bem-vindo de volta',
                            subtitle: 'Faça login com a sua conta',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: ListenableProvider(
                              create: (_) => presenter,
                              child: Form(
                                child: Column(
                                  children: <Widget>[
                                    const EmailInput(),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 32),
                                      child: PasswordInput(),
                                    ),
                                    const LoginButton(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        R.strings.forgotPassword,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])),
              ],
            ),
          ),
        );
      }),
    );
  }
}
