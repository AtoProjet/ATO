import 'package:ato/components/actions.dart';
import 'package:ato/sr_screens/home_screen.dart';
import 'package:ato/sr_screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/app_layout.dart';
import '../components/constants.dart';
import '../db/firebaseChatServices.dart';
import '../models/user.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/topbar.dart';

class UserNotificationsPage extends StatefulWidget {
  const UserNotificationsPage({super.key});

  @override
  State<UserNotificationsPage> createState() => _UserNotificationsPageState();
}

class _UserNotificationsPageState extends State<UserNotificationsPage> {
  UserModel user = UserModel.user!;
  Stream? getAllUserNotifications;
  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  onTheLoad() async {
    getAllUserNotifications =
        await FirebaseChatServices().getUserNotifications(user.id);
    setState(() {});
  }

  updateUserNotificationIsSeen(bool sendClicked, String notId) async {
    await FirebaseChatServices().updateUserNotification(notId);
  }
  Color kQuoteBackgroundColorN = Color(0xFFE1E1E1);
  @override
  Widget build(BuildContext context) {

    //const kQuoteBackgroundColorY = Color(0xFFACD3AC);
    LocaleProvider loc = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Topbar(
              isBack: true,
              onTap: () {
                goToScreenAndClearHistory(context, HomeScreen());
              },
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 5, 0),
              child: Text(
                loc.of(Tr.notifications),
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
        stream: getAllUserNotifications,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    String formattedDate =
                        DateFormat('dd/MM/yyyy h:mma').format(ds["time"].toDate());

                    if(ds["isSeen"] == false){
                      kQuoteBackgroundColorN = Color(0xFFdaffcc);
                    }
                    else if(ds["isSeen"] == true){
                      kQuoteBackgroundColorN = Color(0xFFE1E1E1);
                    }

                    return InkWell(
                      onTap: () {
                        if(ds["isSeen"] == false){
                          updateUserNotificationIsSeen(true, ds["id"]);
                        }
                        showDialog(
                            barrierLabel: "ok",
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Notification"),
                                  content: Text(ds["message"],
                                      ),
                                  actions: [
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                    ),
                                  ],
                                ));
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            width: size.width * 1,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(

                              color: kQuoteBackgroundColorN,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Message", style: kLabelProfileName_font,),
                                Gap(5),
                                Text(ds["message"],style: kNotificationTextFont, overflow: TextOverflow.ellipsis),
                                Gap(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(formattedDate,style: kLabelNotificationTimeFont ,textAlign: TextAlign.end,)
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
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  // showAlertDialog(BuildContext context, DocumentSnapshot dss) {
  //
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text("OK"),
  //     onPressed: () { },
  //   );
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Notification"),
  //     content: Text(dss["message"]),
  //     actions: [
  //       okButton,
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
