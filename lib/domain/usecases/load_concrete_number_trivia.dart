import 'package:dartz/dartz.dart';
import 'package:flutter_clean/data/protocols/repositories/repositories.dart';
import 'package:flutter_clean/domain/entities/number_trivia.dart';
import 'package:flutter_clean/domain/errors/errors.dart';

class LoadConcreteNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;

  LoadConcreteNumberTrivia(this.numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> execute({
    required int number,
  }) async {
    return await numberTriviaRepository.loadConcreteNumberTrivia(number);
  }
}