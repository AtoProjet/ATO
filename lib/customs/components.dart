import 'package:ato/customs/styles.dart';
import 'package:flutter/material.dart';

AppBar getAppBar(BuildContext context, String text,
    {bool showBackground = true,
    bool showBackIcon = true,
    double height = 140.0}) {
  return AppBar(
    flexibleSpace: showBackground
        ? const Image(
            image: AssetImage('assets/images/header.png'),
            fit: BoxFit.cover,
          )
        : null,
    leading: GestureDetector(
      onTap: () {
        if (showBackIcon) {
          Navigator.pop(context);
        }
      },
      child: showBackIcon
          ? const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 32,
            )
          : null,
    ),
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.deepOrange,
        fontSize: 32,
      ),
    ),
    toolbarHeight: height,
  );
}

MaterialButton darkMaterialButton({
  required VoidCallback? onPressed,
  Widget? child,
  Color? color,
  bool enabled = true,
}) {
  // color ??= hexToColor("A4BBCAFF");
  color ??= Colors.indigo;
  return MaterialButton(
    onPressed: enabled ? onPressed : null,
    color: color,
    textColor: Colors.white,
    elevation: 5,
    disabledColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(15),
    child: child,
  );
}
MaterialButton lightMaterialButton({
  required onPressed,
  Widget? child,
  Color? color,
  Color? textColor,
  enabled= false,
}) {
  textColor ??= Colors.indigo;
  color ??= Colors.grey.shade300;
  return MaterialButton(
    onPressed: enabled ? onPressed : null,
    color: color,
    textColor: textColor,
    elevation: 5,
    disabledColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(15),
    child: child,
  );
}
