import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  int hexValue = int.parse(hexColor, radix: 16);
  return Color(hexValue | 0xFF000000);
}
ButtonStyle darkButtonStyle({ double fontSize = 16.0, Color? color  , }) {
  color??= hexToColor("A4BBCAFF");
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.grey.shade300,
    backgroundColor: color,
    textStyle: TextStyle(fontSize: fontSize),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(15),
  );
}

ButtonStyle buttonStyle({double fontSize = 14.0}) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.indigo,
    textStyle: TextStyle(fontSize: fontSize),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(15),
  );
}

TextStyle headerStyle({double fontSize = 24.0}) {
  return TextStyle(
    color: Colors.indigo.shade700,
    fontWeight: FontWeight.w800,
    fontSize: fontSize,
  );
}

void setAsFullScreen({bool isFullScreen= true}) {
  SystemChrome.setEnabledSystemUIMode(
    isFullScreen ? SystemUiMode.immersive : SystemUiMode.edgeToEdge,
    overlays: [],
  );}
