import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean/data/protocols/repositories/repositories.dart';
import 'package:flutter_clean/domain/entities/entities.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}
void main() {
  late LoadConcreteNumberTrivia sut;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    sut = LoadConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final number = 1;
  final numberTrivia = NumberTrivia(text: 'any_text', number: 1);
  test('should get trivia for number from repository', () async {
      when(mockNumberTriviaRepository.loadConcreteNumberTrivia(1))
        .thenAnswer((_) async => Right(numberTrivia));

      final result = await sut.execute(number: number);

      expect(result, const Right(NumberTrivia));
      verify(mockNumberTriviaRepository.loadConcreteNumberTrivia(number));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}