//interface to be implemented in the infrastructure layer

import 'package:dartz/dartz.dart';

import '../entities/advice_Entity.dart';
import '../failures/failures.dart';

abstract class AdvicerRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi();
}
