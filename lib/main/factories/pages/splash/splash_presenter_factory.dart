import 'package:flutter_clean/main/factories/factories.dart';
import 'package:flutter_clean/application/presenters/presenters.dart';
import 'package:flutter_clean/ui/pages/pages.dart';

SplashPresenter makeGetxSplashPresenter() {
  return GetxSplashPresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());
}
