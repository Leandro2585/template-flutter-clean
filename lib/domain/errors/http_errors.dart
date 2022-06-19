import './failure.dart';

class ServerFailure extends Failure {
  @override
  String get message => 'Não foi possível processar seu pedido, tente novamente mais tarde.';
}

class NotFoundFailure extends Failure {
  @override
  String get message => 'Registro não encontrado';
}