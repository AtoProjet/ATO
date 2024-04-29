import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Color cardBackgroundColor= hexToColor("#A8E1E1E1");
final Color buttonColor=  hexToColor("213045").withOpacity(0.5);

Color hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  int hexValue = int.parse(hexColor, radix: 16);
  return Color(hexValue | 0xFF000000);
}

// Color cardBackgroundColor(){
//   return hexToColor("#D9D9D9");
// }

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

ButtonStyle buttonStyle({double fontSize = 14.0, Color? textColor, double borderRadius= 8}) {
  return ElevatedButton.styleFrom(
    foregroundColor: textColor,
    textStyle: TextStyle(fontSize: fontSize),
    elevation: 5,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  );
}

TextStyle headerStyle({double fontSize = 20.0, Color color= Colors.blueGrey}) {
  return TextStyle(
    color: color,
    fontWeight: FontWeight.w800,
    fontSize: fontSize,
  );
}

void setAsFullScreen(bool isFullScreen) {
  SystemChrome.setEnabledSystemUIMode(
    isFullScreen ? SystemUiMode.immersive : SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.bottom],
  );
}

Size screenSize(BuildContext context){
  return MediaQuery.of(context).size;
}