import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_clean/main/factories/factories.dart';
import 'package:flutter_clean/ui/components/components.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'Flutter Clean Arch',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: makeLoginPage),
        GetPage(
            name: '/surveys',
            page: () => const Scaffold(body: Text('Enquetes'))),
      ],
    );
  }
}
