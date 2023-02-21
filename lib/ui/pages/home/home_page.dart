import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed("/story"),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16),
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
