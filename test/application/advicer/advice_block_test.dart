import 'package:api_name/application/advicer/advicer_bloc.dart';
import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:api_name/domain/failures/failures.dart';
import 'package:api_name/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_block_test.mocks.dart';

@GenerateMocks([AdvicerUsecases])
void main() {
  //define variables for later
  late AdvicerBloc advicerBloc;
  late MockAdvicerUsecases mockAdvicerUsecases;

  setUp((() {
    //set up dependencies
    mockAdvicerUsecases = MockAdvicerUsecases();
    advicerBloc = AdvicerBloc(usecases: mockAdvicerUsecases);
  }));

  test("initState should be AdvicerInital", () {
    expect(advicerBloc.state, equals(AdvicerInitial()));
  });

  group("AdviceRequestedEvent", (() {
    final tAdvice = AdviceEntity(advice: "test", id: 1);
    const tAdviceString = "test";
    const tAdviceInt = 1;

    test("should call usecase if event is added", () async {
      //arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

      //act
      advicerBloc.add(AdviceRequestedEvent());
      await untilCalled(mockAdvicerUsecases.getAdviceUsecase());

      //assert
      verify(mockAdvicerUsecases.getAdviceUsecase());
      verifyNoMoreInteractions(mockAdvicerUsecases);
    });

    test("should emit loading then the loaded state after event is added ",
        () async {
      //arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

      //assert later
      final expected = [
        AdvicerStateLoading(),
        AdvicerStateLoaded(advice: tAdviceString, id: tAdviceInt)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expected));
      //act
      advicerBloc.add(AdviceRequestedEvent());
    });
    test(
        "should emit loading then the the server error state after event is added --> usecase failed",
        () async {
      //arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(ServerFailures()));

      //assert later
      final expected = [
        AdvicerStateLoading(),
        AdvicerStateError(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expected));
      //act
      advicerBloc.add(AdviceRequestedEvent());
    });
    test(
        "should emit loading then the the general error state after event is added --> usecase failed",
        () async {
      //arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(GeneralFailures()));

      //assert later
      final expected = [
        AdvicerStateLoading(),
        AdvicerStateError(message: GENERAL_FAILURES_MESSAGE)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expected));
      //act
      advicerBloc.add(AdviceRequestedEvent());
    });
  }));
}
