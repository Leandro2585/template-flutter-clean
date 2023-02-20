import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:flutter_clean/ui/pages/splash/splash.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({Key key, @required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    return Scaffold(
      body: Builder(builder: (context) {
        presenter.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page);
          }
        });
        return const Center(
          child: Image(
            image: AssetImage('lib/ui/assets/full-logo.png'),
          ),
        );
      }),
    );
  }
}
