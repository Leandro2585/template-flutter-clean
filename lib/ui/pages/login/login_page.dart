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
    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
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
                const Headline1(text: 'Login'),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: ListenableProvider(
                    create: (_) => presenter,
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          const EmailInput(),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordInput(),
                          ),
                          const LoginButton(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person),
                            label: Text(R.strings.addAccount),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
