import 'package:flutter_clean/ui/i18n/strings/strings.dart';

class PtBr implements Translations {
  @override
  String get addAccount => 'Criar conta';

  @override
  String get toEnter => 'Entrar';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get msgRequiredField => 'Campo obrigatório.';

  @override
  String get msgInvalidCredentials => 'Credenciais inválidas.';

  @override
  String get msgInvalidField => 'Campo inválido.';

  @override
  String get msgUnexpected =>
      'Algo errado aconteceu. Tente novamente em breve.';
}
