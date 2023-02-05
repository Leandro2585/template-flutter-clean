import 'package:flutter_clean/ui/i18n/i18n.dart';

enum UIExceptions {
  unexpected,
  invalidField,
  requiredField,
  invalidCredentials,
}

extension UIExceptionsExtension on UIExceptions {
  String get description {
    switch (this) {
      case UIExceptions.invalidField:
        return R.strings.msgInvalidField;
      case UIExceptions.requiredField:
        return R.strings.msgRequiredField;
      case UIExceptions.invalidCredentials:
        return R.strings.msgInvalidCredentials;
      default:
        return R.strings.msgUnexpected;
    }
  }
}
