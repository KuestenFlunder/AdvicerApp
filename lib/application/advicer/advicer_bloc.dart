import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:api_name/domain/failures/failures.dart';
import 'package:api_name/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

const GENERAL_FAILURES_MESSAGE =
    "Ups, somthing gone wrong please try again later!";
const SERVER_FAILURE_MESSAGE = "Ups, API Error, please try again later";

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases usecases;
  AdvicerBloc({required this.usecases}) : super(AdvicerInitial()) {
    //* Request and action handling
    on<AdviceRequestedEvent>(
      (event, emit) async {
        emit(AdvicerStateLoading());

        Either<Failure, AdviceEntity> adviceOrFailure =
            //* getAdvicerUsecase() form usecases DOMAIN layer
            await usecases.getAdviceUsecase();
        //* react to either the left or right side of adviceOrFailure Object
        adviceOrFailure.fold(
          (failure) => emit(
            AdvicerStateError(message: _mapFailureToMassage(failure)),
          ),
          (advice) => emit(
            AdvicerStateLoaded(
              advice: advice.advice,
              id: advice.id,
            ),
          ),
        );
      },
    );
  }
  String _mapFailureToMassage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailures:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailures:
        return GENERAL_FAILURES_MESSAGE;
      default:
        return "Ups, something gone wrong please try again later!";
    }
  }
}
