import 'package:api_name/infrastructure/datasources/theme_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ThemeLocalDatasource themeLocalDatasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeLocalDatasource =
        ThemeLocalDatasourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("Get cached theme data", (() {
    const t_themeData = true;
    test(
        "should return bool (themeData) if there ist one in Shared Preferences",
        (() async {
      //arrange
      when(mockSharedPreferences.getBool(any)).thenReturn(t_themeData);
      //act
      final result = await themeLocalDatasource.getCachedThemeData();
      //assert

      //* verify the call of getBool and also verify the correct key
      verify(mockSharedPreferences.getBool(CACHE_THEME_MODE));
      expect(result, t_themeData);
    }));
  }));

  group("cacheThemeData", (() {
    const t_themeData = true;

    test("should call sharedPreferences to cache theme mode", (() {
      //arrange
      when(mockSharedPreferences.setBool(any, any))
          .thenAnswer((_) async => true);
      //act
      themeLocalDatasource.cacheThemeData(mode: t_themeData);
      //assert
      verify(mockSharedPreferences.setBool(CACHE_THEME_MODE, true));
    }));
  }));
}
