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
    final theme = Theme.of(context);

    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? presenter.auth : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.buttonTheme.colorScheme.primary,
            disabledBackgroundColor: theme.primaryColor,
            textStyle: const TextStyle(),
            fixedSize: const Size(296, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            R.strings.toEnter.toUpperCase(),
            style: theme.textTheme.labelMedium,
          ),
        );
      },
    );
  }
}
