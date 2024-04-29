import 'package:flutter/material.dart';

void goToScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void goToScreenAndClearHistory(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
    (route) => false,
  );
}

void goBack(BuildContext context) {
  Navigator.pop(context);
}

