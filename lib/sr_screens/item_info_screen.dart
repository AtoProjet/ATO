import 'package:ato/components/widgets.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/providers/cart_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemInfoScreen extends StatefulWidget {
  static Tr title = Tr.itemDetails;
  ItemModel item;

  ItemInfoScreen({super.key, required this.item});

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    CartProvider cart = Provider.of(context);
    setAsFullScreen(isFullScreen: false);
    return atoScaffold(
      title: loc.of(ItemInfoScreen.title),
        showAppBarBackground: false,
        context: context,
        body: Card(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 36),
          color: cardBackgroundColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            dragStartBehavior: DragStartBehavior.start,
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.item.image.startsWith("assets")
                        ? Image.asset(
                            widget.item.image,
                            fit: BoxFit.contain,
                            height: 250,
                            alignment: Alignment.center,
                          )
                        : Image.network(
                            widget.item.image,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: 250,
                    child: Text(
                      widget.item.print(loc),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: atoDarkMaterialButton(
                          onPressed: () {
                            cart.addToCart(widget.item);
                          },
                          icon: "assets/icons/add-to-cart.png",
                          text: loc.of(Tr.add),
                          color: buttonColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 150,
                      height: 36,
                      child: atoDarkMaterialButton(
                          onPressed: () {},
                          text: loc.of(Tr.communication),
                          fontSize: 13,
                          color: buttonColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
