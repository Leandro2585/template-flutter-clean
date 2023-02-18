import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String title;
  final String subtitle;
  const Headline1({
    @required this.title,
    @required this.subtitle,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: theme.textTheme.headline1,
        ),
        const Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
        Text(
          subtitle,
          textAlign: TextAlign.start,
          style: theme.textTheme.subtitle1,
        )
      ],
    );
  }
}
