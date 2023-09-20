import 'package:api_name/domain/repositories/theme_repository.dart';
import 'package:flutter/cupertino.dart';

abstract class ThemeService extends ChangeNotifier {
  late bool isDarkModeOn;
  late bool useSystemTheme;
  Future<void> toggleTheme();
  Future<void> toggleUseSystemTheme();
  Future<void> setTheme({required bool mode});
  Future<void> setUseSystemTheme({required bool systemTheme});
  // Called when app starts to watch for local saved theme Mode
  Future<void> init();
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  final ThemeRepository themeRepository;

  ThemeServiceImpl({required this.themeRepository});

  @override
  bool isDarkModeOn = true;
  @override
  late bool useSystemTheme;

  @override
  Future<void> init() async {
    final useSystemThemeOrFailure = await themeRepository.getUseSystemTheme();

    await useSystemThemeOrFailure.fold(
      (failure) async {
        await setUseSystemTheme(systemTheme: false);
      },
      (useSystemTheme) async {
        await setUseSystemTheme(systemTheme: useSystemTheme);
      },
    );
    final modeOrFailure = await themeRepository.getThemeMode();

    modeOrFailure.fold((failure) {
      setTheme(mode: true);
    }, (mode) {
      setTheme(mode: mode);
    });
  }

  @override
  Future<void> setTheme({required bool mode}) async {
    isDarkModeOn = mode;
    //* must be called to inform ChangeNotifier notifiers on changed value
    notifyListeners();
    await themeRepository.setThemeMode(mode: isDarkModeOn);
  }

  @override
  Future<void> toggleTheme() async {
    isDarkModeOn = !isDarkModeOn;
    await setTheme(mode: isDarkModeOn);
  }

  @override
  Future<void> setUseSystemTheme({required bool systemTheme}) async {
    useSystemTheme = systemTheme;
    //* must be called to inform ChangeNotifier notifiers on changed value
    notifyListeners();
    await themeRepository.setUseSystemTheme(useSystemTheme: useSystemTheme);
  }

  @override
  Future<void> toggleUseSystemTheme() async {
    useSystemTheme = !useSystemTheme;
    await setUseSystemTheme(systemTheme: useSystemTheme);
  }
}
