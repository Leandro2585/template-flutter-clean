import 'package:dartz/dartz.dart';
import 'package:flutter_clean/domain/entities/number_trivia.dart';
import 'package:flutter_clean/domain/errors/failure.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> loadConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> loadRandomNumberTrivia();
}