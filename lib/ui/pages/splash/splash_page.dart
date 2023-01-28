import 'package:flutter/material.dart';
import 'package:flutter_clean/ui/pages/splash/splash.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({Key key, @required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Clean')),
      body: Builder(builder: (context) {
        presenter.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page);
          }
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
