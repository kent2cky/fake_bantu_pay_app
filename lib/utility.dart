import 'package:flutter/material.dart';

class Utility {
  TextStyle getTextStyle(
      {FontWeight? fontWeight = FontWeight.w300,
      double? fontSize,
      Color? color = const Color.fromARGB(255, 124, 123, 123),
      double letterSpacing = 0}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontSize: fontSize,
    );
  }

  UnderlineInputBorder getEnabledBorderColor() => const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      );
}
