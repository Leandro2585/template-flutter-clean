import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean/ui/i18n/i18n.dart';
import 'package:flutter_clean/ui/pages/login/login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? presenter.auth : null,
          child: Text(R.strings.toEnter.toUpperCase()),
        );
      },
    );
  }
}
