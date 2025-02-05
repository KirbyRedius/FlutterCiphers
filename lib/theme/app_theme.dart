import 'package:cryptography_methods/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData mainTheme = ThemeData(
      fontFamily: AppFonts.primaryFont,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        tertiary: AppColors.black,
        secondary: AppColors.secondaryColor,
        onSurface: AppColors.white,
      ),
      useMaterial3: true,
      textTheme: AppTextTheme.textTheme);
}
