import 'package:ato/admin_screens/sendNotification_screen2.dart';
import 'package:ato/components/constants.dart';
import 'package:ato/widgets/admin_widgets/common_widgets/topbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../db/firebaseChatServices.dart';
import '../widgets/admin_widgets/common_widgets/genBtn.dart';
import 'donatedItems_screen.dart';

class SendNotificationPage1 extends StatefulWidget {
  const SendNotificationPage1({super.key});

  @override
  State<SendNotificationPage1> createState() => _SendNotificationPage1State();
}

class _SendNotificationPage1State extends State<SendNotificationPage1> {
  TextEditingController msgTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool validate() {
      bool res = false;
      if (msgTextController.text.isNotEmpty) {
        res = true;
      }
      return res;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Topbar(isBack: false),
            Gap(120),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        "Enter Message :",
                        style: kLabelProfileName_font,
                      ),
                      Gap(20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 3,
                            controller: msgTextController,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC5C5C5)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                                //prefixIcon: Icon(Icons.account_circle, size: 27, color: kTextFeildIconColor),

                                fillColor: Color(0xFFFFFCFC),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[500])),
                          ),
                        ),
                      ),

                      // TextField(
                      //   controller: msgTextController,
                      //   maxLines: 2,
                      // ),
                      Gap(20),
                      GenBtn(
                        buttonText: 'Next',
                        onTap: () {
                          bool isValidate = validate();

                          if (isValidate) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SendNotificationPage2(
                                        MsgText: msgTextController.text,
                                      )),
                            );
                          } else if (!isValidate) {
                            var snackBar = SnackBar(
                              content: Text('The Message Cannot Be Empty !'),
                              backgroundColor: Colors.redAccent,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
