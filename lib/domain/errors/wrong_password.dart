import 'package:template_flutter_clean/domain/errors/failure.dart';

class WrongPassword extends Failure {
  @override
  String get message => 'Senha incorreta';
}