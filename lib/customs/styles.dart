import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ButtonStyle darkButtonStyle({double fontSize = 16.0}) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.indigo,
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

void setAsFullScreen({bool isFullScreen= true}) {
  SystemChrome.setEnabledSystemUIMode(
    isFullScreen ? SystemUiMode.immersive : SystemUiMode.edgeToEdge,
    overlays: [],
  );}
