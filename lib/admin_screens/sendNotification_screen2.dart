

import 'package:ato/components/actions.dart';
import 'package:ato/sr_screens/success_screen.dart';
import 'package:ato/widgets/admin_widgets/common_widgets/genBtn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/app_layout.dart';
import '../components/constants.dart';
import '../components/tools.dart';
import '../components/widgets/images.dart';
import '../db/firebaseChatServices.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/topbar.dart';
import 'accountActionConfirmationScreen.dart';

class SendNotificationPage2 extends StatefulWidget {

  final String MsgText;
  const SendNotificationPage2({super.key, required this.MsgText});

  @override
  State<SendNotificationPage2> createState() => _SendNotificationPage2State();
}

List multipleSelected = [];
List<Map<String, dynamic>> usersList = [];
Future<List<Map<String, dynamic>>> getUserDetails() async {
  usersList = await FirebaseChatServices().getUserAccountsSN();
  //setState(() {});
  return usersList;
}


class _SendNotificationPage2State extends State<SendNotificationPage2> {
  addNotification(bool sendClicked) async {
    for (final items in multipleSelected) {
      String id = randomAlphanumeric(10);
      Map<String, dynamic> messageInfoMap = {
        "id" : id,
        "receiverID": items["id"],
        "name": items["name"],
        "message": widget.MsgText,
        //"message": "Hi this is dummy notification text",
        "time": FieldValue.serverTimestamp(),
        "isSeen": false,
        "isDeleted": false
      };
      FirebaseChatServices()
          .addNotification(id, messageInfoMap)
          .then((value) {
        goToScreenAndClearHistory(
            context,
            AccountActionConfirmation(
              action: 'Successs ',
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    LocaleProvider loc = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: false,
          children: [
            Topbar(
              isBack: true,
              onTap: () {
                multipleSelected.clear();
                Navigator.pop(context);
              },
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 5, 0),
              child: Text(
                loc.of(Tr.selectUsers),
                style: kLabelEduMaterialsH_font,
              ),
            ),
            Gap(15),
            Container(
              height: size.height * 2.5,
              width: size.width * 0.85,

              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                color: kQuoteBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(child: UserAccountsList(loc)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(20),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GenBtn(
                            buttonText: "Send",
                            onTap: () {
                              addNotification(true);
                            },
                          )
                        ])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget UserAccountsList(LocaleProvider loc) {
    final size = AppLayout.getSize(context);
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) return Text("ERROR: ${snapshot.error}");
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          var data = snapshot.data!;
          return Column(
            children: List.generate(
              data.length,
              (index) => Expanded(
                child: StatefulBuilder(builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Container(
                    width: size.width * 0.85,
                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: Column(
                      children: [
                        Gap(5),
                        CheckboxListTile(
                          secondary: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(46)),
                            child: Image.asset(
                              "assets/images/ic_user_male.jpg",
                              width: 45,
                              height: 45,
                              fit: BoxFit.fill,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                          dense: true,
                          title: Text(
                            data[index]["name"],
                            style: kLabelSelectUsers_font
                          ),
                          value: data[index]["isChecked"],
                          onChanged: (value) {
                            print(data[index]);
                            setState(() {
                              print("checkinggggggg : " + value.toString());
                              data[index]["isChecked"] = value;
                              print(" the new value is " +
                                  data[index]["isChecked"].toString());
                              if(value == true){
                                print ("true case");
                                if (!multipleSelected.contains(data[index])) {

                                  multipleSelected.add(data[index]);
                                }
                              }
                              else if(value == false){
                                print("false case");
                                if (multipleSelected.contains(data[index])) {
                                  multipleSelected.remove(data[index]);
                                }

                              }

                              // if (multipleSelected.contains(data[index])) {
                              //   multipleSelected.remove(data[index]);
                              // } else {
                              //   multipleSelected.add(data[index]);
                              // }
                            });
                            print("the multi select ");
                            print(multipleSelected);
                          },
                        ),
                        Gap(15),
                        Divider(height: 1, color: Colors.black26,)
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        });
    // return StreamBuilder(
    //     stream: getAllUserAccounts,
    //     builder: (context, AsyncSnapshot snapshot) {
    //       return snapshot.hasData
    //           ? ListView.builder(
    //               padding: EdgeInsets.zero,
    //               itemCount: snapshot.data.docs.length,
    //               shrinkWrap: true,
    //               primary: false,
    //               itemBuilder: (context, index) {
    //                 DocumentSnapshot ds = snapshot.data.docs[index];
    //
    //                 return Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Icon(
    //                           Icons.account_circle,
    //                           size: 28,
    //                         ),
    //                         Gap(5),
    //                         Text(ds["name"]),
    //                         Gap(10),
    //                         // StatefulBuilder(
    //                         //   builder: (BuildContext context,
    //                         //       void Function(void Function()) setState) {
    //                         //     return Checkbox(
    //                         //         activeColor: kPrimaryColor,
    //                         //         value: isDonorChecked,
    //                         //         onChanged: (value) {
    //                         //           setState(() {
    //                         //             isDonorChecked = !isDonorChecked!;
    //                         //           });
    //                         //         });
    //                         //   },
    //                         // )
    //
    //                         // CheckboxListTile(
    //                         //   controlAffinity: ListTileControlAffinity.leading,
    //                         //   contentPadding: EdgeInsets.zero,
    //                         //   dense: true,
    //                         //   title: Text(
    //                         //     ds["name"],
    //                         //     style: const TextStyle(
    //                         //       fontSize: 16.0,
    //                         //       color: Colors.black,
    //                         //     ),
    //                         //   ),
    //                         //   value: checkListItems[index]["value"],
    //                         //   onChanged: (value) {
    //                         //     setState(() {
    //                         //       checkListItems[index]["value"] = value;
    //                         //       if (multipleSelected.contains(checkListItems[index])) {
    //                         //         multipleSelected.remove(checkListItems[index]);
    //                         //       } else {
    //                         //         multipleSelected.add(checkListItems[index]);
    //                         //       }
    //                         //     });
    //                         //   },
    //                         // ),
    //
    //
    //
    //
    //                       ],
    //                     ),
    //                     Gap(15),
    //                   ],
    //                 );
    //               })
    //           : Center(
    //               child: CircularProgressIndicator(),
    //             );
    //     });
  }
}
