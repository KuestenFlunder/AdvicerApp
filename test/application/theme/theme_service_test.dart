import 'package:api_name/application/theme/theme_service.dart';
import 'package:api_name/domain/failures/failures.dart';
import 'package:api_name/domain/repositories/theme_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  late MockThemeRepository mockThemeRepository;
  late ThemeService themeService;
  late int listenerCount;
  setUp((() {
    listenerCount = 0;
    mockThemeRepository = MockThemeRepository();
    themeService = ThemeServiceImpl(themeRepository: mockThemeRepository)
      ..addListener(() {
        listenerCount++;
      });
  }));

  test("check if default value for darkmode is true", () {
    //assert
    expect(themeService.isDarkModeOn, true);
  });

  group("setThemeMode", () {
    const tMode = false;
    test("should set theme to the parameter it gets, store theme information",
        () {
      //arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);
      //act
      themeService.setTheme(mode: tMode);
      //assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });
  group("toggleTheme", () {
    const tMode = false;
    test(
        "should toggle theme to the parameter it gets, store theme information",
        () {
      //arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);
      //act
      themeService.setTheme(mode: tMode);
      //assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });
  group("init", () {
    const tMode = false;
    test(
        "should get a theme mode from local data source and use it and notify listeners",
        () async {
      //arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => const Right(tMode));
      //act
      await themeService.init();
      //assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });

    test(
        "should start with darkmode if no thmeme is returned from local source",
        () async {
      //arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => Left(CacheFailure()));
      //act
      await themeService.init();
      //assert
      expect(themeService.isDarkModeOn, true);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });
  });
}
