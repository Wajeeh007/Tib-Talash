import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tib_talash/helpers/constants.dart';

class ThemeHelpers {

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true
    ).copyWith(
    scaffoldBackgroundColor: lightThemeBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark
          )
      )
    );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true
  ).copyWith(
    scaffoldBackgroundColor: greenPalette.shade800,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light
        )
    )
  );

}