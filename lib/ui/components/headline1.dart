import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String text;
  const Headline1({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: theme.textTheme.headline1,
    );
  }
}
