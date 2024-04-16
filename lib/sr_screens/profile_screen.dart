import 'package:ato/components/constants.dart';
import 'package:ato/components/widgets.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/db/firebaseChatServices.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/user.dart';
import 'package:ato/sr_screens/chat_support_screen.dart';
import 'package:ato/sr_screens/login_screen.dart';
import 'package:ato/components/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/tools.dart';

class ProfileScreen extends StatefulWidget {
  static String title = "Profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user = UserModel.user!;
  final double _fontSize= 18;
  final double _iconSize= 32;

  @override
  Widget build(BuildContext context) {
    return atoScaffold(
      context: context,
      showAppBarBackground: false,
      showBottomBar: true,
      title: ProfileScreen.title,
      body: Center(
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
              margin: const EdgeInsets.fromLTRB(36,20, 36, 20 ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(UserModel.user!.role== "Admin")
                      TextButton(
                        onPressed: () {},
                        child:  Row(
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
                              "Notifications",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      if(UserModel.user!.role== "Admin")
                      const Divider(),
                      if(UserModel.user!.role== "Donor" || UserModel.user!.role== "Admin")
                      TextButton(
                        onPressed: () {},
                        child:  Row(
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
                              "Orders",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      if(UserModel.user!.role== "Donor" || UserModel.user!.role== "Admin")
                      const Divider(),
                      TextButton(
                        onPressed: () {},
                        child:  Row(
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
                              "عربي",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () async{
                          print("Starting the function to create chatroom");
                          String adminId = GenAdminId;
                          var chatRoomId =
                          getChatRoomIdById(user.id, adminId);
                          print("Chat Room id is "+ chatRoomId);
                          //print("Creating chatRoomInfoMap");

                          Map<String, dynamic> chatRoomInfoMap = {
                            "users": [user.id, adminId ],
                          };
                          print("Triggering Database methods");

                          await FirebaseChatServices()
                              .createChatRoom(chatRoomId, chatRoomInfoMap);
                          print("Completed");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatSupportScreen(
                                      name: user.name, userId: user.id )));


                        },
                        child:  Row(
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
                              "Support",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          logout();
                        },
                        child:  Row(
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
                              "Logout",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
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
      ),
    );
  }

  logout(){
    Fire.auth.signOut().then((value){
      setState(() {
        UserModel.user= null;
        goToScreenAndClearHistory(context, const LoginScreen());
      });

    });
  }

  notifications(){

  }

  changeLanguage(String lang){

  }
  showOrders(){

  }

}
