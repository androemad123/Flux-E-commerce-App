import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontWeight: fontWeight,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontSize: fontSize);
}

TextStyle regularStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle boldStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
