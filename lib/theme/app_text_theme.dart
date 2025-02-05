import 'package:cryptography_methods/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AppTextTheme {
  static TextTheme textTheme = TextTheme(
    bodySmall: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontWeight: FontWeight.w600,
      fontSize: 25.dp,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontWeight: FontWeight.w600,
      fontSize: 31.75.dp,
    ),
  );
}
