import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      color: const Color.fromRGBO(239, 244, 255, 1),
      margin: const EdgeInsets.only(bottom: 32),
      child: const Padding(
        padding: EdgeInsets.only(top: 48),
        child: Image(
          image: AssetImage('lib/ui/assets/logo.png'),
        ),
      ),
    );
  }
}
