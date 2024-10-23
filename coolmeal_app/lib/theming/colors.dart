import 'package:flutter/material.dart';

class ColorsManager {
  static const Color mainGreen = Color(0xFF4AA28B);
  static const Color secondaryGreen = Color(0xFF9AD174);
  static const Color gradient = Color(0xFFE9F2E3);
  static const Color gray = Color(0xFF757575);
  static const Color gray93Color = Color(0xFFEDEDED);
  static const Color gray76 = Color(0xFFC2C2C2);
  static const Color darkBlue = Color(0xFF242424);
  static const Color lightShadeOfGray = Color(0xFFFDFDFF);
  static const Color mediumLightShadeOfGray = Color(0xFF9E9E9E);
  static const Color coralRed = Color(0xFFFF4C5E);
  static const Color textFieldFillColor = Color.fromRGBO(255, 255, 255, 1);
}

LinearGradient welcomeGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [0.0, 0.3, 0.9],
  colors: [
    Colors.white.withOpacity(0.7),
    Colors.white.withOpacity(0.7),
    ColorsManager.gradient,
  ],
);
