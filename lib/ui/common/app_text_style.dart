import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const TextStyle bigPlusPlus = TextStyle(
    fontFamily: 'Inter',
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle bigPlus = TextStyle(
    fontFamily: 'Inter',
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle big = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle bigLight = TextStyle(
    //fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: kcDarkGreyColor,
  );
  static const TextStyle h1Bold = TextStyle(
    //fontFamily: 'Helvetica',
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle h2Bold = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle h3Bold = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle h4Bold = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle h4Normal = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: kcDarkGreyColor,
  );
  static const TextStyle h5Normal = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: kcDarkGreyColor,
  );
  static const TextStyle thinSmall = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: kcDarkGreyColor,
  );
  static const TextStyle boldSmall = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: kcDarkGreyColor,
  );
  static const TextStyle verySmall = TextStyle(
    //fontFamily: 'Helvetica',
    fontSize: 9,
    fontWeight: FontWeight.normal,
    color: kcDarkGreyColor,
  );
  static withColor({
    required Color color,
    required TextStyle style,
  }) =>
      style.copyWith(color: color);

  static withSize({
    required TextStyle style,
    required FontWeight weight,
    Color? color,
  }) =>
      style.copyWith(fontWeight: weight, color: color);
}
