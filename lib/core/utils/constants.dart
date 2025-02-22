import 'package:flutter/material.dart';

const List<Color> categoryColors = [
  Color(0xffA71F30),
  Color(0xffEC4227),
  Color(0xffFFCB68),
  Color(0xff59A14A),
  Color(0xff5EA793),
  Color(0xff0687A6),
  Color(0xff8749AC),
  Color(0xff5A43BF),
];

Color lightColor(Color color, [double amount = 0.2]) {
  assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');

  final hsl = HSLColor.fromColor(color);

  final lightHsl = hsl.withLightness((hsl.lightness + amount).clamp(0, 1));
  return lightHsl.toColor();
}

Color darkColor(Color color, [double amount = 0.3]) {
  assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');

  final hsl = HSLColor.fromColor(color);

  final darkHsl = hsl.withLightness((hsl.lightness - amount).clamp(0, 1));
  return darkHsl.toColor();
}
