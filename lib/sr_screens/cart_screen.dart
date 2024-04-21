import 'package:ato/components/actions.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets.dart';
import 'package:ato/models/item.dart';
import 'package:ato/providers/cart_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/success_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static Tr title= Tr.cart;
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    CartProvider cart = Provider.of(context);
    setAsFullScreen(isFullScreen: false);
    if(cart.items.isEmpty){
      return Center(child: Text(loc.of(Tr.yourCartIsEmpty), textAlign: TextAlign.center, style: TextStyle(fontSize: 24),));
    }
    return ListView(
            padding: const EdgeInsets.all(8.0),
            dragStartBehavior: DragStartBehavior.start,
            scrollDirection: Axis.vertical,
            children: [
              for(ItemModel item in cart.items)
    Card(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        color: cardBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: item.image.startsWith("assets")
                          ? Image.asset(
                        item.image,
                        fit: BoxFit.contain,
                        height: 150,
                        alignment: Alignment.center,
                      )
                          : Image.network(
                        item.image,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),
              ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 20),
                      width: 120,
                      child: Text(
                        item.print(loc),
                      ),
                    ),
              ]),
        ),
            ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: atoDarkMaterialButton(
                        onPressed: () {
                          submit(cart);
                        },
                        text: loc.of(Tr.continueText),
                        color: buttonColor),
                  ),
                ),
              ),

            ]);
  }

 void submit(CartProvider cart){
    cart.clear();
    goToScreen(context, SuccessScreen(message: Tr.thankYou));
 }
}
