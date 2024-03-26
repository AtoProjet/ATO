import 'package:ato/components/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static String title= "Cart";
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return atoScaffold(
      context: context,
      showAppBarBackground: false,
      showBottomBar: true,
      title: CartScreen.title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
               Text(CartScreen.title),
            ],
          ),
        ),
      ),
    );
  }
}
