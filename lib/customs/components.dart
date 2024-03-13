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
    leading:
        GestureDetector(
      onTap: () {
        if(showBackIcon) {
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
    toolbarHeight: height, // Set your desired height
  );
}
