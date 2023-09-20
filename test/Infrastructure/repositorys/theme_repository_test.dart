import 'package:api_name/domain/failures/failures.dart';
import 'package:api_name/domain/repositories/theme_repository.dart';
import 'package:api_name/infrastructure/datasources/theme_local_datasource.dart';
import 'package:api_name/infrastructure/exceptions/exceptions.dart';
import 'package:api_name/infrastructure/repositories/theme_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([ThemeLocalDatasource])
void main() {
  late ThemeRepository themeRepository;
  late MockThemeLocalDatasource mockThemeLocalDatasource;

  setUp((() {
    mockThemeLocalDatasource = MockThemeLocalDatasource();
    themeRepository =
        ThemeRepositoryImpl(themeLocalDatasource: mockThemeLocalDatasource);
  }));

  group("setThemeMode", (() {
    const tThemeMode = true;
    test("should call function to cache theme mode in local data source", (() {
      //arrange
      when(mockThemeLocalDatasource.cacheThemeData(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);
      //act
      themeRepository.setThemeMode(mode: tThemeMode);

      //assert
      //* verify that the getCachedThemeData was called
      verify(mockThemeLocalDatasource.cacheThemeData(mode: tThemeMode));
    }));
  }));

  group("getThemeMode", () {
    const tThemeMode = true;

    test("should return ThemeMode if cached data is present", () async {
      //arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenAnswer((_) async => tThemeMode);
      //act
      final result = await themeRepository.getThemeMode();
      //assert
      verify(mockThemeLocalDatasource.getCachedThemeData());
      expect(result, const Right(tThemeMode));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
    test(
        "should return Cache Failure when local data source throws an exception",
        () async {
      //arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenThrow(CacheException());
      //act
      final result = await themeRepository.getThemeMode();
      //assert
      verify(mockThemeLocalDatasource.getCachedThemeData());
      expect(result, Left(CacheFailure()));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
  });
}
