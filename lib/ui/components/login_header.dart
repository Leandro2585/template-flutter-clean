import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 240,
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [theme.primaryColorLight, theme.primaryColorDark],
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            color: Colors.black,
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
        ),
      ),
      child: const Image(image: AssetImage('lib/ui/assets/logo.png')),
    );
  }
}
