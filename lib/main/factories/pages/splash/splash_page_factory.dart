import 'package:flutter/material.dart';
import 'package:flutter_clean/main/factories/factories.dart';
import 'package:flutter_clean/ui/pages/pages.dart';

Widget makeSplashPage() {
  return SplashPage(presenter: makeGetxSplashPresenter());
}
