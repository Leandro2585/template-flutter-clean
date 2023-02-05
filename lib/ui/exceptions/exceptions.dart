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
        return 'Campo inválido.';
      case UIExceptions.requiredField:
        return 'Campo obrigatório.';
      case UIExceptions.invalidCredentials:
        return 'Credenciais inválidas.';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
