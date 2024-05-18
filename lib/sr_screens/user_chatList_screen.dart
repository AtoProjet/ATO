import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/firebaseChatServices.dart';
import '../models/user.dart';
import '../widgets/admin_widgets/chatWidgets/chatListTile.dart';

class UserChatListPage extends StatefulWidget {
  const UserChatListPage({super.key});

  @override
  State<UserChatListPage> createState() => _UserChatListPageState();
}

class _UserChatListPageState extends State<UserChatListPage> {
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


          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else{

            return snapshot.hasData
                ? ListView.builder(
                shrinkWrap: true,
                primary: false,
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
          }


        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      //appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ChatRoomList(),],
        ),
      )
    );
  }


  // Widget _buildUI() {
  //   return SafeArea(
  //       child: ListView(
  //         children: [
  //           _messagesListView(),
  //         ],
  //       ));
  // }
  //
  // Widget _messagesListView() {
  //   return SizedBox(
  //       //height: MediaQuery.sizeOf(context).height * 0.76,
  //       width: MediaQuery.sizeOf(context).width,
  //       child: Column(
  //         children: [
  //           ListView(
  //             shrinkWrap: true,
  //             primary: false,
  //             children: [ChatRoomList()],
  //           )
  //         ],
  //       ));
  // }
}
