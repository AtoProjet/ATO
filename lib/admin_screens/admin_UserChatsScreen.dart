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
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    String formattedDate =
                        DateFormat('h:mma').format(ds["time"].toDate());

                    return ChatListTile(
                      lastMessage: ds["lastMessage"],
                      chatRoomId: ds.id,
                      myuserid: user.id,
                      time: formattedDate,
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
      resizeToAvoidBottomInset: true,
      //appBar: _appBar(),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    LocaleProvider loc = Provider.of(context);
    return SafeArea(
        child: ListView(
      shrinkWrap: true,
      children: [
        Topbar(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AdminHome()));
            //Navigator.pop(context);
          },
          isBack: false,
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

        ChatRoomList()
        //_messagesListView(),
      ],
    ));
  }

  Widget _messagesListView() {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.72,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [ChatRoomList()],
        ));
  }
}
