import 'package:ato/components/actions.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/providers/cart_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/tools.dart';
import '../db/firebaseChatServices.dart';
import '../models/user.dart';
import 'chat_support_screen.dart';

class ItemInfoScreen extends StatefulWidget {
  static Tr title = Tr.itemDetails;
  ItemModel item;

  ItemInfoScreen({super.key, required this.item});

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  UserModel user = UserModel.user!;
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    CartProvider cart = Provider.of(context);
    setAsFullScreen(true);
    return atoScaffold(
      title: loc.of(ItemInfoScreen.title),
        showAppBarBackground: false,
        context: context,
        body: Card(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          color: cardBackgroundColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            dragStartBehavior: DragStartBehavior.start,
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.item.image.startsWith("assets")
                        ? Image.asset(
                            widget.item.image,
                            fit: BoxFit.contain,
                            height: 250,
                      width: 300,
                            alignment: Alignment.center,
                          )
                        : Image.network(
                            widget.item.image,
                      height: 250,
                            width: 300,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    width: 250,
                    alignment: Alignment.topRight
                    ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.item.print(loc),
                          ),
                        ),
                        if(widget.item is ClothModel)
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: [
                          Text("${loc.of(Tr.color)}: "),
                          Container(width: 35, height: 20, color: Color((widget.item as ClothModel).color),)
                        ],)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: atoIconTextMaterialButton(
                          onPressed: () async {
                            cart.addToCart(widget.item);
                           atoToastSuccess(context, loc.of(Tr.itemAddedSuccessfully));
                              goBack(context);
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
                          onPressed: () async{

                            print(widget.item.donorId);
                            String donorId = widget.item.donorId;
                            var chatRoomId =
                            getChatRoomIdById(user.id, donorId);
                            //print("Creating chatRoomInfoMap");

                            Map<String, dynamic> chatRoomInfoMap = {
                              "users": [user.id, donorId ],
                            };
                            await FirebaseChatServices()
                                .createChatRoom(chatRoomId, chatRoomInfoMap);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatSupportScreen(
                                        name: user.name, userId2: donorId )));




                          },
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
