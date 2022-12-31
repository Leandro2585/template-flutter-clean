import 'package:flutter_clean/ui/pages/login/login.dart';
import 'package:flutter_clean/main/factories/factories.dart';
import 'package:flutter_clean/application/presenters/presenters.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(
    validation: makeLoginValidation(),
    authentication: makeRemoteAuthentication(),
  );
}
