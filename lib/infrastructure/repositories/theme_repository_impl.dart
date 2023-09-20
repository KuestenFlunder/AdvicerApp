import 'package:api_name/infrastructure/datasources/theme_local_datasource.dart';
import 'package:dartz/dartz.dart';

import 'package:api_name/domain/failures/failures.dart';

import '../../domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      final themeMode = await themeLocalDatasource.getCachedThemeData();
      return Right(themeMode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> setThemeMode({required bool mode}) {
    return themeLocalDatasource.cacheThemeData(mode: mode);
  }

  @override
  Future<Either<Failure, bool>> getUseSystemTheme() async {
    try {
      final themeMode = await themeLocalDatasource.getUseSystemTheme();
      return Right(themeMode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> setUseSystemTheme({required bool useSystemTheme}) {
    return themeLocalDatasource.cacheUseSystemTheme(
        useSystemTheme: useSystemTheme);
  }
}
