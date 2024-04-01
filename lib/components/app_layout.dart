import 'package:flutter/material.dart';
// This class has the screen size of the present device to make the ui responsive.
class AppLayout{
  static getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
}