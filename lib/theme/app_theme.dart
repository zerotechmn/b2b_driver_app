import 'package:b2b_driver_app/theme/app_colors.dart';
import 'package:b2b_driver_app/theme/palette.dart';
import 'package:b2b_driver_app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Palette.background[700],
    scaffoldBackgroundColor: Palette.background,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Palette.background,
      scrolledUnderElevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: Palette.background,
      selectedItemColor: Palette.label,
      unselectedItemColor: Palette.label[100],
      selectedLabelStyle: AppTextStyles.bodyMedium.copyWith(
        color: Palette.label,
      ),
      unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(
        color: Palette.label[100],
      ),
    ),
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        primary: Palette.primary,
        success: Palette.success,
        warning: Palette.warning,
        danger: Palette.danger,
        backgroundPrimary: Palette.background,
        backgroundSecondary: Palette.background[200],
        backgroundTertiary: Palette.background[300],
        labelPrimary: Palette.label,
        labelSecondary: Palette.label[100],
        labelTertiary: Palette.label[200],
        iconPrimary: Palette.icon,
        iconSecondary: Palette.icon[100],
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Palette.background,
    scaffoldBackgroundColor: Palette.background[700],
    brightness: Brightness.light,
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Palette.background[700],
      scrolledUnderElevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: Palette.background[700],
      selectedItemColor: Palette.label[500],
      unselectedItemColor: Palette.label[600],
      selectedLabelStyle: AppTextStyles.bodyMedium.copyWith(
        color: Palette.label[500],
      ),
      unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(
        color: Palette.label[600],
      ),
    ),
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        primary: Palette.primary,
        success: Palette.success,
        warning: Palette.warning,
        danger: Palette.danger,
        backgroundPrimary: Palette.background[900],
        backgroundSecondary: Palette.background[800],
        backgroundTertiary: Palette.background[700],
        labelPrimary: Palette.label[500],
        labelSecondary: Palette.label[600],
        labelTertiary: Palette.label[700],
        iconPrimary: Palette.icon[500],
        iconSecondary: Palette.icon[600],
      ),
    ],
  );
}

TextTheme textTheme(context) =>
    Theme.of(context).textTheme.apply(bodyColor: colors(context).labelPrimary);
AppColors colors(context) => Theme.of(context).extension<AppColors>()!;
