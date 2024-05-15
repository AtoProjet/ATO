import 'package:ato/admin_screens/admin_home.dart';
import 'package:ato/components/constants.dart';
import 'package:ato/db/firebaseChatServices.dart';
import 'package:ato/widgets/admin_widgets/common_widgets/topbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/chatWidgets/chatListTile.dart';

class AdminUserChatScreen extends StatefulWidget {
  const AdminUserChatScreen({super.key});

  @override
  State<AdminUserChatScreen> createState() => _AdminUserChatScreenState();
}

class _AdminUserChatScreenState extends State<AdminUserChatScreen> {
  UserModel user = UserModel.user!;
  Stream? chatRoomStream;
  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  Future<String> getUserInfo(String chatroomid, String myuserid) async {
    String user2id = chatroomid.replaceAll("_", "").replaceAll(myuserid, "");
    QuerySnapshot querySnapshot =
        await FirebaseChatServices().getUserInfo(user2id);
    String name = "${querySnapshot.docs[0]["name"]}";

    return name;
  }

  onTheLoad() async {
    chatRoomStream = await FirebaseChatServices().getChatLists(user.id);
    setState(() {});
  }

  Widget ChatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    String formattedDate =
                        DateFormat('h:mma').format(ds["time"].toDate());

                    return Column(
                      children: [
                        ChatListTile(
                          lastMessage: ds["lastMessage"],
                          chatRoomId: ds.id,
                          myuserid: user.id,
                          time: formattedDate,
                        ),
                      ],
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: _appBar(),
      body: _buildUI(),
    );
  }

  // PreferredSizeWidget _appBar() {
  //   return AppBar(
  //     backgroundColor: Colors.white,
  //     title:
  //   );
  // }

  Widget _buildUI() {
    LocaleProvider loc = Provider.of(context);
    return SafeArea(
        child: Column(
      children: [
        Topbar(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AdminHome()));
            //Navigator.pop(context);
          },
          isBack: true,
        ),
        Gap(5),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 5, 0),
          child: Text(
            loc.of(Tr.support),
            style: kLabelEduMaterialsH_font,
          ),
        ),
        Gap(15),

        // Container(
        //   padding: EdgeInsets.only(left: 10, top: 15),
        //   alignment: Alignment.bottomRight,
        //   width: double.infinity,
        //   height: 100.0,
        //   child: SizedBox(
        //     height: 80,
        //     child:  Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         GestureDetector(
        //           onTap: () {
        //             Navigator.pushReplacement(context, MaterialPageRoute(
        //                 builder: (context) => AdminHome()));
        //             //Navigator.pop(context);
        //           },
        //           child: Icon(
        //             Icons.arrow_back,
        //           ),
        //         ),
        //         Image(
        //           image: AssetImage('assets/images/ic_logo.jpg'),
        //           fit: BoxFit.contain,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        _messagesListView(),
      ],
    ));
  }

  Widget _messagesListView() {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.72,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              primary: false,
              children: [ChatRoomList()],
            )
          ],
        ));
  }
}
