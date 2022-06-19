import 'package:dartz/dartz.dart';
import 'package:template_flutter_clean/domain/entities/index.dart';
import 'package:template_flutter_clean/domain/errors/index.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> auth({ required String email, required String password });
}