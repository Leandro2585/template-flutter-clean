import 'package:flutter/material.dart';
import 'package:flutter_clean/ui/pages/pages.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Arch',
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}