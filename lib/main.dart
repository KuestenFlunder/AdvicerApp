import 'package:api_name/application/advicer/advicer_bloc.dart';
import 'package:api_name/presentation/advicer/advicer_page.dart';
import 'package:api_name/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'application/theme/theme_service.dart';
import 'injection.dart' as di;
// di == dependency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl<ThemeService>().init();
  runApp(ChangeNotifierProvider(
    create: (context) => di.sl<ThemeService>(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          title: 'Advicer',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.useSystemTheme
              ? ThemeMode.system
              : themeService.isDarkModeOn
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home: BlocProvider(
            create: (BuildContext context) => di.sl<AdvicerBloc>(),
            child: const AdvicerPage(),
          ),
        );
      },
    );
  }
}
