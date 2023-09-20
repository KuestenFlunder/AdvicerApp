import 'package:api_name/infrastructure/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHE_THEME_MODE = "CHACHE_THEME_MODE";
const CACHE_USE_SYSTEM_THEME_MODE = "CACHE_USE_SYSTEM_THEME_MODE";

abstract class ThemeLocalDatasource {
  Future<bool> getCachedThemeData();
  Future<bool> getUseSystemTheme();
  Future<void> cacheThemeData({required bool mode});
  Future<void> cacheUseSystemTheme({required bool useSystemTheme});
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheThemeData({required bool mode}) {
    return sharedPreferences.setBool(CACHE_THEME_MODE, mode);
  }

  @override
  Future<bool> getCachedThemeData() {
    final modeBool = sharedPreferences.getBool(CACHE_THEME_MODE);

    if (modeBool != null) {
      return Future.value(modeBool);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUseSystemTheme({required bool useSystemTheme}) {
    return sharedPreferences.setBool(
        CACHE_USE_SYSTEM_THEME_MODE, useSystemTheme);
  }

  @override
  Future<bool> getUseSystemTheme() {
    final useSystemTheme =
        sharedPreferences.getBool(CACHE_USE_SYSTEM_THEME_MODE);

    if (useSystemTheme != null) {
      return Future.value(useSystemTheme);
    } else {
      throw CacheException();
    }
  }
}
