import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:member360/core/theme/colors/app_colors.dart';
import 'package:member360/core/theme/colors/app_light_colors.dart';
import 'package:member360/core/theme/themes/app_theme.dart';

class AppLightTheme extends AppTheme {
  final AppColors _colorsLight = AppLightColors();

  @override
  ThemeData get theme => ThemeData(
        fontFamily: AppTheme.fontFamily,
        colorScheme: colorScheme,
        // textTheme: textTheme,
        brightness: Brightness.dark,
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(_colorsLight.secondary),
        ),
        unselectedWidgetColor: Colors.black45,
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(_colorsLight.primary),
          checkColor: WidgetStateProperty.all(_colorsLight.primary),
        ),
        appBarTheme: AppBarTheme(
          color: _colorsLight.background,
          elevation: 0,
          centerTitle: true,
          // titleTextStyle: textTheme.headline2!.copyWith(color: _colorsLight.black),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light),
          iconTheme: IconThemeData(color: _colorsLight.black, size: 21),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            decorationThickness: 0,
          ),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            decorationThickness: 0,
          ),
          errorStyle: TextStyle(height: 0.8),
        ),
        scaffoldBackgroundColor: _colorsLight.background,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return _colorsLight.disableGray;
              }
              return _colorsLight.primary;
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return _colorsLight.disableGray;
              }
              return _colorsLight.primary;
            },
          ),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            return (Colors.white).withValues(alpha: 0.12);
          }),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(12)),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )),
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: AppColors.snackBarGreenSuccess),
      );

  // @override
  // TextTheme get textTheme => AppTextTheme();

  @override
  ColorScheme get colorScheme => ColorScheme(
        primary: _colorsLight.primary,
        onPrimary: _colorsLight.white,
        secondary: _colorsLight.secondary,
        onSecondary: _colorsLight.white,
        error: AppColors.snackBarRedError,
        onError: _colorsLight.white,
        surface: _colorsLight.primary,
        onSurface: _colorsLight.white,
        brightness: Brightness.dark,
      );
}
