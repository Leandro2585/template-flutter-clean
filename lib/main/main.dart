import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_clean/ui/i18n/i18n.dart';
import 'package:flutter_clean/main/factories/factories.dart';
import 'package:flutter_clean/ui/components/components.dart';

void main() {
  R.load(const Locale('pt', 'BR'));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final routeObserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());

    return GetMaterialApp(
      title: 'Blogger',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(
            name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(
          name: '/surveys',
          page: () => const Scaffold(body: Text('Enquetes')),
          transition: Transition.fadeIn,
        )
      ],
    );
  }
}
