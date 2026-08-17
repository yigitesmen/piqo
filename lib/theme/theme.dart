import 'package:flutter/material.dart';

class AppTheme {
  static const Color brandRed = Color(0xFFD6293D);
  static const Color brandRedDark = Color(0xFF7E1220);
  static final MaterialColor brandRedSwatch = _createSwatch(brandRed);

  static const LinearGradient authGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [brandRed, brandRedDark],
  );

  static MaterialColor _createSwatch(Color color) {
    final strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
    final swatch = <int, Color>{};
    final r = (color.r * 255.0).round();
    final g = (color.g * 255.0).round();
    final b = (color.b * 255.0).round();
    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.toARGB32(), swatch);
  }

  static final lightTheme = ThemeData(
    primarySwatch: brandRedSwatch,
    primaryColor: brandRed,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: brandRedSwatch),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0.5,
      backgroundColor: Colors.grey.shade200,
      foregroundColor: Colors.black,
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
