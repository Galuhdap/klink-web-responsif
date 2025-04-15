
import 'package:flutter/material.dart';
import 'package:klinik_web_responsif/core/styles/app_sizes.dart';
class ThemeConfig {
  // light mode
  static Color baseGreen = Color(0xFFF4CAF50);
  static Color red80 = Color(0xFFFFDEDF);
  static Color neutral0 = Color(0xFF2B2D2F);
  static Color neutral30 = Color(0xFF727983);
  static Color neutral40 = Color(0xFFDFE3E9);
  static Color neutral50 = Color(0xFFA6AEB9);
  static Color neutral70 = Color(0xFFDFE3E9);
  static Color neutral80 = Color(0xFFF0F2F4);
  static Color neutral100 = Color(0xFFFFFFFFF);

  static ThemeData lightMode = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      dividerColor: neutral70,
      textTheme: TextTheme(
        titleLarge: titleLarge,
        titleSmall: titleSmall,
        titleMedium: titleMedium,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
        bodyMedium: bodyMedium,
      ));

  static TextStyle titleLarge = TextStyle(
    fontSize: FontSize.s32,
    fontWeight: FontWeight.w700,
    height: 1.3,
    fontFamily: "PlusJakartaSans",
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: FontSize.s20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    fontFamily: "PlusJakartaSans",
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: FontSize.s14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    fontFamily: "PlusJakartaSans",
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle labelLarge = TextStyle(
    fontSize: FontSize.s16,
    fontWeight: FontWeight.w700,
    height: 1.3,
    fontFamily: "PlusJakartaSans",
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: FontSize.s14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    fontFamily: "PlusJakartaSans",
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: FontSize.s14,
    fontWeight: FontWeight.w700,
    height: 1.3,
    fontFamily: "PlusJakartaSans",
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: FontSize.s14,
    fontWeight: FontWeight.w400,
    height: 1.3,
    fontFamily: "PlusJakartaSans",
    leadingDistribution: TextLeadingDistribution.even,
  );
}