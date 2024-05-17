import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/app_layout.dart';
import '../components/constants.dart';
import '../db/firebaseChatServices.dart';
import '../models/user.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/topbar.dart';

class OrdersListPage extends StatefulWidget {
  const OrdersListPage({super.key});

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  UserModel user = UserModel.user!;
  Stream? getUserOrders;
  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  onTheLoad() async {
    getUserOrders = await FirebaseChatServices().getUserOrders(user.id);
    setState(() {});
  }

  late DocumentSnapshot itemInfo;

  Future<DocumentSnapshot> getItemInfo(String itemId) async {
    itemInfo = await FirebaseChatServices().getItemDetails(itemId);
    print("78966");
    print(itemInfo["name"]);

    return itemInfo;
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Topbar(
              isBack: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 5, 0),
              child: Text(
                loc.of(Tr.orders),
                style: kLabelEduMaterialsH_font,
              ),
            ),
            Gap(15),
            UserAccountsList()
            //ManageAccountCard(username: 'Johanna Doe', type: 'Donor 856475',),
          ],
        ),
      ),
    );
  }

  Widget UserAccountsList() {
    final size = AppLayout.getSize(context);
    return StreamBuilder(
        stream: getUserOrders,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    print(ds);

                    Map<String, dynamic> itemsIds =
                        ds['pickedItems'] as Map<String, dynamic>;

                    print('Map keys: ${itemsIds.keys}');
                    print(itemsIds);

                    if (itemsIds.isNotEmpty) {
                      // itemsIds.forEach((key, value) {
                      //   print('Key: $key, Value: $value');
                      // });

                      return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(

                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              width: size.width * 1,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              decoration: BoxDecoration(
                                color: kQuoteBackgroundColor,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Order Id :",
                                        style:
                                        kNotificationTextFont,
                                      ),
                                      Gap(5),
                                      Flexible(
                                        child: Text(
                                            "${ds.id.substring(0,13)}",
                                            style:
                                            kOrderId,
                                            overflow:
                                            TextOverflow
                                                .ellipsis),
                                      ),
                                    ],
                                  ),

                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: itemsIds.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> newData;
                                        List<String> keysIds = [];
                                        List<String> qty = [];
                                        itemsIds.forEach((key, value) {
                                          print('Key: $key, Value: $value');
                                          keysIds.add(key);
                                          qty.add(value.toString());
                                        });
                                        // print(" the item key is adsfs");
                                        // print(itemsIds[1]);
                                        // Map<String, String> itemm = itemsIds[index];
                                        // print(" the item key is ");
                                        // print(itemsIds[1]);
                                        //MapEntry<String, String> item = itemsIds[index];
                                        return FutureBuilder<DocumentSnapshot>(
                                            future: getItemInfo(keysIds[index]),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<DocumentSnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError)
                                                return Text(
                                                    "ERROR: ${snapshot.error}");
                                              if (!snapshot.hasData)
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());

                                              late DocumentSnapshot data =
                                                  snapshot.data!;
                                              print("45");
                                              print(data);
                                              return Row(
                                                children: [

                                                  Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Item : ",
                                                            style:
                                                                kNotificationTextFont,
                                                          ),
                                                          Gap(5),
                                                          Flexible(
                                                            child: Text(
                                                                "${data["name"]}",
                                                                style:
                                                                kItemName,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                          Gap(5),
                                                        ],
                                                      )),
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Text(
                                                        "Qty : ",
                                                        style:
                                                            kNotificationTextFont,
                                                      ),
                                                      Gap(5),
                                                      Text("${qty[index]}",
                                                          style:
                                                              kLabelProfileName_font,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      Gap(5),
                                                    ],
                                                  )),
                                                ],
                                              );
                                            });
                                      }),

                                  // FutureBuilder<DocumentSnapshot>(
                                  //
                                  //     future: getItemInfo(itemsIds.keys.first),
                                  //     builder: (BuildContext context,
                                  //         AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  //       if (snapshot.hasError)
                                  //         return Text("ERROR: ${snapshot.error}");
                                  //       if (!snapshot.hasData)
                                  //         return Center(child: CircularProgressIndicator());
                                  //
                                  //       late DocumentSnapshot data = snapshot.data!;
                                  //       return Row(
                                  //         children: [
                                  //           Text(data["name"], style: kLabelProfileName_font,),
                                  //           Gap(5),
                                  //           Text("Test Message",style: kNotificationTextFont, overflow: TextOverflow.ellipsis),
                                  //           Gap(10),
                                  //         ],
                                  //       );
                                  //     }),
                                  Gap(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${ds["deliveryDate"]} : ${ds["deliveryTime"]}",
                                        style: kLabelNotificationTimeFont,
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.black45,
                            )
                          ],
                        ),
                      );
                    }
                    // String formattedDate =
                    // DateFormat('dd/MM/yyyy h:mma').format(ds["time"].toDate());
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
