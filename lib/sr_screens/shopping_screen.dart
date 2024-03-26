import 'package:ato/components/widgets.dart';
import 'package:ato/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  static String title= "Shopping";
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return atoScaffold(
      showAppBarBackground: false,
      context: context,
      title: ShoppingScreen.title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: const [
               Text('This is Shopping Screen'),
            ],
          ),
        ),
      ),
    );
  }
}
