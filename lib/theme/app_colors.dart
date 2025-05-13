import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primary;
  final Color? danger;
  final Color? success;
  final Color? warning;
  final Color? backgroundPrimary;
  final Color? backgroundSecondary;
  final Color? backgroundTertiary;
  final Color? labelPrimary;
  final Color? labelSecondary;
  final Color? labelTertiary;
  final Color? iconPrimary;
  final Color? iconSecondary;

  const AppColors({
    required this.primary,
    required this.danger,
    required this.success,
    required this.warning,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.labelPrimary,
    required this.labelSecondary,
    required this.labelTertiary,
    required this.iconPrimary,
    required this.iconSecondary,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? danger,
    Color? success,
    Color? warning,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? labelPrimary,
    Color? labelSecondary,
    Color? labelTertiary,
    Color? iconPrimary,
    Color? iconSecondary,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      danger: danger ?? this.danger,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      labelPrimary: labelPrimary ?? this.labelPrimary,
      labelSecondary: labelSecondary ?? this.labelSecondary,
      labelTertiary: labelTertiary ?? this.labelTertiary,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      danger: Color.lerp(primary, other.danger, t),
      success: Color.lerp(primary, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
      backgroundPrimary: Color.lerp(
        backgroundPrimary,
        other.backgroundPrimary,
        t,
      ),
      backgroundSecondary: Color.lerp(
        backgroundSecondary,
        other.backgroundSecondary,
        t,
      ),
      backgroundTertiary: Color.lerp(
        backgroundTertiary,
        other.backgroundTertiary,
        t,
      ),
      labelPrimary: Color.lerp(labelPrimary, other.labelPrimary, t),
      labelSecondary: Color.lerp(labelSecondary, other.labelSecondary, t),
      labelTertiary: Color.lerp(labelTertiary, other.labelTertiary, t),
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t),
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t),
    );
  }
}
