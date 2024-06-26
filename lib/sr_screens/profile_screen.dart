import 'package:ato/components/constants.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/images.dart';
import 'package:ato/db/firebaseChatServices.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/chat_support_screen.dart';
import 'package:ato/sr_screens/login_screen.dart';
import 'package:ato/components/actions.dart';
import 'package:ato/sr_screens/orders_list_screen.dart';
import 'package:ato/sr_screens/user_notifications_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/tools.dart';

class ProfileScreen extends StatefulWidget {
  static Tr title = Tr.profile;

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel user;
  final double _fontSize = 18;
  final double _iconSize = 32;
  @override
  void initState() {
    user = UserModel.user!;

    super.initState();

    //getUserNotificationsCount();
  }

  Future<int> getUserNotificationsCount() async {
    int notification = await FirebaseChatServices().getNotificationCounts();
    return notification;
  }

  @override
  Widget build(BuildContext context) {
    setAsFullScreen(true);
    LocaleProvider loc = Provider.of(context);
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: [
          atoProfileImage(url: user.image),
          Center(
              child: Text(
            user.name,
            style: headerStyle(),
          )),
          Center(child: Text(user.email)),
          Container(
            margin: const EdgeInsets.fromLTRB(36, 20, 36, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //if(user.role== "Admin")
                    TextButton(
                      onPressed: () {
                        goToScreen(context, UserNotificationsPage());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            Icons.notifications_outlined,
                            color: Colors.black87,
                            size: _iconSize,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            loc.of(Tr.notifications),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: _fontSize,
                                fontWeight: FontWeight.w700),
                          ),

                          Flexible(
                            child: FutureBuilder<int>(
                                future: getUserNotificationsCount(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<int> count) {
                                  if (count.hasError)
                                    return Text("ERROR: ${count.error}");
                                  if (!count.hasData)
                                    return Center(
                                        child: CircularProgressIndicator());

                                  return Column(
                                    children: [
                                      if(count.data! > 0)
                                        Column(
                                        children: [

                                          const SizedBox(width: 60),
                                          CircleAvatar(
                                            radius: 13.0,
                                            child: Text(
                                              count.data.toString(),
                                              style: kNotificationCount_font,
                                            ),
                                            backgroundColor: Colors.redAccent,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          )





                          // if(notification > 0)
                          //   Column(
                          //     children: [
                          //       const SizedBox(width: 60),
                          //       CircleAvatar(
                          //         radius: 13.0,
                          //         child: Text( notification.toString(), style: kNotificationCount_font,),
                          //         backgroundColor: Colors.redAccent,
                          //       )
                          //     ],
                          //   )
                        ],
                      ),
                    ),
                    //if(user.role== "Admin")

                    if (user.role == "Beneficiary")
                      Column(
                        children: [
                          const Divider(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => OrdersListPage()));

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.mark_unread_chat_alt_outlined,
                                  color: Colors.black87,
                                  size: _iconSize,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  loc.of(Tr.orders),
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: _fontSize,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                    //if (user.role == "Donor" || user.role == "Admin")
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        changeLanguage(loc, loc.of(Tr.switchLang));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            Icons.language,
                            color: Colors.black87,
                            size: _iconSize,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            loc.of(Tr.switchLang),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: _fontSize,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    TextButton(
                      onPressed: () async {
                        print("Starting the function to create chatroom");
                        String adminId = GenAdminId;
                        var chatRoomId = getChatRoomIdById(user.id, adminId);
                        print("Chat Room id is " + chatRoomId);
                        //print("Creating chatRoomInfoMap");

                        Map<String, dynamic> chatRoomInfoMap = {
                          "users": [user.id, adminId],
                        };
                        print("Triggering Database methods");

                        await FirebaseChatServices()
                            .createChatRoom(chatRoomId, chatRoomInfoMap);
                        print("Completed");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatSupportScreen(
                                    name: user.name, userId2: GenAdminId)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            Icons.message,
                            color: Colors.black87,
                            size: _iconSize,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            loc.of(Tr.support),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: _fontSize,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        logout();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.black87,
                            size: _iconSize,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            loc.of(Tr.logout),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: _fontSize,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  logout() {
    Fire.auth.signOut().then((value) {
      setState(() {
        goToScreenAndClearHistory(context, const LoginScreen());
      });
    });
  }

  notifications() {}

  changeLanguage(LocaleProvider loc, String lang) {
    Locale target;
    if (lang == "English") {
      target = loc.en();
    } else {
      target = loc.ar();
    }
    loc.setLocale(target);
  }

  showOrders() {}
}
