import 'package:meta/meta.dart';

import 'package:flutter_clean/application/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({@required String field, @required String value}) {
    String error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(value);
      if (error == '') {
        return null;
      } else if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return error;
  }
}
