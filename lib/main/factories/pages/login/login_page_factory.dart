import 'package:flutter/material.dart';

import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:flutter_clean/main/factories/pages/login/login.dart';

Widget makeLoginPage() {
  return LoginPage(presenter: makeGetxLoginPresenter());
}
