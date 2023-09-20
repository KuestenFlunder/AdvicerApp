import 'package:api_name/domain/failures/failures.dart';
import 'package:api_name/domain/entities/advice_Entity.dart';
import 'package:api_name/domain/repositories/advicer_repository.dart';
import 'package:api_name/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:api_name/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdvicerRepositoryImpl implements AdvicerRepository {
  final AdvicerRemoteDatasource advicerRemoteDatasource;

  AdvicerRepositoryImpl({required this.advicerRemoteDatasource});
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    try {
      final remoteAdvice =
          await advicerRemoteDatasource.getRandomAdviceFromApi();
      return Right(remoteAdvice);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailures());
      } else {
        return Left(GeneralFailures());
      }
    }
  }
}
