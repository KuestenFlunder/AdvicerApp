import 'package:api_name/application/advicer/advicer_bloc.dart';
import 'package:api_name/domain/repositories/advicer_repository.dart';
import 'package:api_name/domain/repositories/theme_repository.dart';
import 'package:api_name/domain/usecases/advicer_usecases.dart';
import 'package:api_name/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:api_name/infrastructure/datasources/theme_local_datasource.dart';
import 'package:api_name/infrastructure/repositories/advicer_respository_impl.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'application/theme/theme_service.dart';
import 'infrastructure/repositories/theme_repository_impl.dart';

final sl = GetIt.instance; // sl == service locator

Future<void> init() async {
//! aplication layer
//registration of blocs
// factory always initiate new Object
  sl.registerFactory(
    () => AdvicerBloc(
      usecases: sl(),
    ),
  );

  sl.registerLazySingleton<ThemeService>(() => ThemeServiceImpl(
        themeRepository: sl(),
      ));

  //! Usecases
//LazySingleton always the same Object in runtime when needed
  sl.registerLazySingleton(
    () => AdvicerUsecases(
      advicerRepository: sl(),
    ),
  );

  //! Repos
  sl.registerLazySingleton<AdvicerRepository>(
    () => AdvicerRepositoryImpl(
      advicerRemoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(
        themeLocalDatasource: sl(),
      ));

  //! DataSources
  sl.registerLazySingleton<AdvicerRemoteDatasource>(
    () => AdvicerRemoteDatasourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<ThemeLocalDatasource>(
    () => ThemeLocalDatasourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //! extern
  // register all external sources
  sl.registerLazySingleton(
    () => http.Client(),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
