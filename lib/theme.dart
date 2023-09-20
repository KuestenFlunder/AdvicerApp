import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
//* Color definition Light Mode
  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.blue;

//* Color definition Dark Mode
  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _iconColor = Colors.white;

  static const Color _accentColorDark = Color.fromRGBO(74, 217, 217, 1);

//* Text Styling for light and dark Mode

  static const TextStyle _lightHeadingText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: "Rubik",
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: "Rubik",
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 16);

//* Text Theme for Light Mode

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightHeadingText,
    bodyText1: _lightBodyText,
  );
//*Text Theme for Dark Mode

  static final TextStyle _darkThemeHeadingTextStyle =
      //* copys the lightHeadingText parameter and makes you handel single parameters
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyTextStyle =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkThemeHeadingTextStyle,
    bodyText1: _darkThemeBodyTextStyle,
  );

//*Light Mode : definition of the Theme
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: _appbarColorLight,
      iconTheme: IconThemeData(color: _iconColor),
    ),
    bottomAppBarColor: _lightPrimaryColor,
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      primaryContainer: _lightPrimaryVariantColor,
      secondary: _lightPrimaryColor,
      secondaryContainer: _accentColorDark,
    ),
    textTheme: _lightTextTheme,
  );

//*Dark Mode
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _appbarColorDark,
      iconTheme: const IconThemeData(color: _iconColor),
    ),
    bottomAppBarColor: _darkPrimaryColor,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      onPrimary: _darkOnPrimaryColor,
      primaryContainer: _darkPrimaryVariantColor,
      secondary: _appbarColorDark,
      secondaryContainer: _accentColorDark,
    ),
    textTheme: _darkTextTheme,
  );
}
