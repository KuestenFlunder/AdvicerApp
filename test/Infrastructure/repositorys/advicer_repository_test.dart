import 'dart:math';

import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:api_name/domain/failures/failures.dart';
import 'package:api_name/domain/repositories/advicer_repository.dart';
import 'package:api_name/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:api_name/infrastructure/exceptions/exceptions.dart';
import 'package:api_name/infrastructure/models/advice_model.dart';
import 'package:api_name/infrastructure/repositories/advicer_respository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_repository_test.mocks.dart';

@GenerateMocks([AdvicerRemoteDatasource])
// run flutter packages run build_runner build --delete-conflicting-outputs
// to generate the mock folder

void main() {
  // 1. define variables
  late AdvicerRepository advicerRepository;
  late MockAdvicerRemoteDatasource mockAdvicerRemoteDatasource;

  // 2. define Setup
  setUp(() {
    mockAdvicerRemoteDatasource = MockAdvicerRemoteDatasource();
    advicerRepository = AdvicerRepositoryImpl(
        advicerRemoteDatasource: mockAdvicerRemoteDatasource);
  });

  // 3 define Groups for the Unit tests. Every function gets its own group with its own Unit tests
  group("getAdviceFromAPI", () {
    // 4. set up local variables to test with
    // Models and Entity should be tested separately
    final tAdviceModel = AdviceModel("test", 1);
    final AdviceEntity tAdvice = tAdviceModel;

    // 5. write the Test
    test(
        "should return remote data if the call to remote data source is successfully",
        () async {
      // arrange (the expected result)
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi())
          .thenAnswer((_) async => tAdviceModel);
      // act (test the function and save the result)
      final result = await advicerRepository.getAdviceFromApi();

      // assert (verify the results)
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Right(tAdvice));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });

    test("should return server failure if data source throws server-exception",
        () async {
      // arrange (the expected result)
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi())
          .thenThrow(ServerException());
      // act (test the function and save the result)
      final result = await advicerRepository.getAdviceFromApi();

      // assert (verify the results)
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Left(ServerFailures()));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });

    test("should return general failure if data source throws server-exception",
        () async {
      // arrange (the expected result)
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi()).thenThrow(e);
      // act (test the function and save the result)
      final result = await advicerRepository.getAdviceFromApi();
      // assert (verify the results)
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Left(GeneralFailures()));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });
  });
}
