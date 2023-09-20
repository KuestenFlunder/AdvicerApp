import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:api_name/domain/failures/failures.dart';
import 'package:api_name/domain/repositories/advicer_repository.dart';
import 'package:api_name/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_usecases_test.mocks.dart';

//* Tells Flutter for which list of classes, fake classes should be mocked

//! Call: flutter packages run build_runner build --delete-conflicting-outputs
//to run build process of mocks and generates new file with mocks

@GenerateMocks([AdvicerRepository])
void main() {
  //* want to test AdvicerUsecases with dependency AdvicerRepository
  //* need of mocking AdvicerRepository with GenerateMocks

  late AdvicerUsecases advicerUsecases;
  late MockAdvicerRepository mockAdvicerRepository;

  setUp(() {
    mockAdvicerRepository = MockAdvicerRepository();
    advicerUsecases = AdvicerUsecases(advicerRepository: mockAdvicerRepository);
  });

//each function test must be grouped
  group("getAdviceUsecase", () {
//test adviceEntity
    final tAdvice = AdviceEntity(
      advice: "TEST",
      id: 1,
    );

    test("should return the same advice as repo", () async {
      //arrange

      when(mockAdvicerRepository.getAdviceFromApi())
          .thenAnswer((_) async => Right(tAdvice));

      //act

      final result = await advicerUsecases.getAdviceUsecase();

      //assert
      expect(result, Right(tAdvice));
      verify(mockAdvicerRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
    test("should return the same ServerFailure as repo", () async {
      //arrange

      when(mockAdvicerRepository.getAdviceFromApi())
          .thenAnswer((_) async => Left(ServerFailures()));

      //act

      final result = await advicerUsecases.getAdviceUsecase();

      //assert
      expect(result, Left(ServerFailures()));
      verify(mockAdvicerRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
    test("should return the same GeneralFailure as repo", () async {
      //arrange

      when(mockAdvicerRepository.getAdviceFromApi())
          .thenAnswer((_) async => Left(GeneralFailures()));

      //act

      final result = await advicerUsecases.getAdviceUsecase();

      //assert
      expect(result, Left(GeneralFailures()));
      verify(mockAdvicerRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
  });
}
