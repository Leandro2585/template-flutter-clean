import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean/ui/i18n/i18n.dart';
import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:flutter_clean/ui/exceptions/exceptions.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIExceptions>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.strings.email,
            errorText: snapshot.hasData ? snapshot.data.description : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}
