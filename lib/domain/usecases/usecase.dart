import 'package:dartz/dartz.dart';
import 'package:template_flutter_clean/domain/errors/index.dart';

abstract class UseCase<Type, Input> {
  Future<Either<Failure, Type>> call(Input input);
}