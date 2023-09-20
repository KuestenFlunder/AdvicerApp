import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import '../repositories/advicer_repository.dart';

class AdvicerUsecases {
  final AdvicerRepository advicerRepository;
  AdvicerUsecases({required this.advicerRepository});

  Future<Either<Failure, AdviceEntity>> getAdviceUsecase() async {
    //* getAdviceFromApi from INFRASTRUCTURE/repo impl
    return advicerRepository.getAdviceFromApi();
  }
}
