import 'package:ato/components/actions.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/providers/cart_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/delivery_details_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static Tr title = Tr.cart;

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? _error;

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    CartProvider cart = Provider.of(context);
    setAsFullScreen(true);
    if (cart.items.isEmpty) {
      return Center(child: Text(
        loc.of(Tr.yourCartIsEmpty), textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),));
    }
    return SizedBox(
      height: screenSize(context).height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 96.0),
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.vertical,

        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              for(int index = 0; index < cart.items.length; index++ )
                Builder(builder: (context) {
                  final item = cart.items.keys.elementAt(index);
                  final quantity = cart.items[item];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    color: cardBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: item.image.startsWith("assets")
                                ? Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                              height: 140,
                              width: 140,
                              alignment: Alignment.center,
                            )
                                : Image.network(
                              item.image,
                              fit: BoxFit.contain,
                              height: 140,
                              width: 140,
                              alignment: Alignment.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 135,
                              width: 150,
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                    Text(item.print(loc),
                                    maxLines: 5,
                                    ),
                                  Container(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(

                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.only(top: 32))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(loc.of(Tr.removeItem), style: TextStyle(color: Colors.grey.shade700) ,),
                                          const Gap(10),
                                           Icon(Icons.close, size: 20, color: Colors.red.shade700,),
                                        ],
                                      ),
                                      onPressed: () {
                                        cart.removeFromCart(item);
                                      },
                                    ),
                                  ),
                                ],

                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  );
                }),

              Container(
                padding: EdgeInsets.only(top: cart.count()==1? screenSize(context).height/3: cart.count()==2? screenSize(context).height/6: 10),
                alignment: Alignment.bottomCenter,
                child: atoDarkMaterialButton(
                    onPressed: () {
                      goToScreen(context, const DeliveryDetailsScreen());
                    },
                    text: loc.of(Tr.continueText),
                    color: buttonColor),
              ),

            ]),
      ),
    );
  }

}