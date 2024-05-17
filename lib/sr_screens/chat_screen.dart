import 'package:ato/components/tools.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/db/firebaseChatServices.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../components/constants.dart';
import '../models/user.dart';

class ChatScreen extends StatefulWidget {
  static Tr title= Tr.chat;

  final String name;
  final String userId2;
  const ChatScreen({super.key, required this.name, required this.userId2});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserModel user = UserModel.user!;

  TextEditingController _messagecontroller = new TextEditingController();
  String? messageId, chatRoomId, adminId;
  Stream? messageStream;

  ontheload() async {
    adminId = GenAdminId;
    //chatRoomId = getChatRoomIdById(widget.userId2,adminId!);
    chatRoomId = getChatRoomIdById(user.id,widget.userId2);

    getAndSetMessages();
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  getAndSetMessages() async {
    messageStream = await FirebaseChatServices().getChatRoomMessages(chatRoomId);
    setState(() {});
  }


  Widget chatMessageTile(String message, bool sendByMe) {

    return Row(
      mainAxisAlignment:
      sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(12),
                      topRight:
                      sendByMe ? const Radius.circular(0) : const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                      topLeft:
                      sendByMe ? const Radius.circular(12) : const Radius.circular(0)),
                  color: sendByMe ? const Color(0xFFebebeb) : kChat2Color),
              child: Text(message),
            )),
      ],
    );
  }

  Widget chatMessage() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: const EdgeInsets.only(bottom: 90, top: 130),
              itemCount: snapshot.data.docs.length,
              reverse: true,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return chatMessageTile(
                    ds["message"], user.id == ds["senderId"]);
              })
              : const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  addMessage(bool sendClicked) {
    print("starting to addMessage");
    if (_messagecontroller.text != null) {
      print("Message Found");
      String message = _messagecontroller.text;
      _messagecontroller.text = "";
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('h:mma').format(now);

      print("my user name is  " + adminId!);
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "senderId": user.id,
        "sendBy": user.name,
        "timestamp": formattedDate,
        "time": FieldValue.serverTimestamp(),
        "imgUrl": "abcd"
      };
      if (messageId == null) {
        print("Message Id is Null");
        messageId = randomAlphanumeric(10);
      }

      FirebaseChatServices()
          .addMessage(chatRoomId!, messageId!, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": formattedDate,
          "time": FieldValue.serverTimestamp(),
          "lastMessageSenderId": user.id,
          "lastMessageSendBy": user.name
        };
        FirebaseChatServices()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          messageId = null;
        }
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 0),
            child: Stack(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1.12,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0))),
                    child: chatMessage()),


                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _messagecontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: const TextStyle(color: Colors.black45),
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  addMessage(true);
                                },
                                child: const Icon(Icons.send_rounded))),
                      ),


                    ),
                  ),
                ),
              ],
            ),
          ),
      //],
      //  ),
      //),
      //  ),
    );
  }





}
