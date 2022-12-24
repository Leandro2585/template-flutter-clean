import 'package:flutter/material.dart';
import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    final theme = Theme.of(context);

    return StreamBuilder<String>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
            icon: Icon(
              Icons.email,
              color: theme.primaryColorLight,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}
