import 'package:ato/components/tools.dart';
import 'package:ato/db/firebaseChatServices.dart';
import 'package:ato/sr_screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../components/constants.dart';
import '../models/user.dart';

class ChatSupportScreen extends StatefulWidget {
  final String name;
  final String userId2;
  const ChatSupportScreen({super.key, required this.name, required this.userId2});

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
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
  bool isValid(){
    bool valid = false;

    if(_messagecontroller.text.isNotEmpty){
      valid = true;
    }
    return valid;
  }

  Widget chatMessageTile(String message, bool sendByMe) {

    return Row(
      mainAxisAlignment:
      sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topLeft:
                      sendByMe ? Radius.circular(12) : Radius.circular(0)),
                  color: sendByMe ? Color(0xFFebebeb) : kChat2Color),
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
              padding: EdgeInsets.only(bottom: 90, top: 130),
              itemCount: snapshot.data.docs.length,
              reverse: true,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return chatMessageTile(
                    ds["message"], user.id == ds["senderId"]);
              })
              : Center(
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 0),
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1.12,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0))),
                    child: chatMessage()),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.bottomRight,
                  width: double.infinity,
                  height: 100.0,
                  child: SizedBox(
                    height: 80,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ProfileScreen()));
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/images/ic_logo.jpg'),
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      padding: EdgeInsets.only(
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
                            hintStyle: TextStyle(color: Colors.black45),
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  bool validate  = isValid();
                                  if(validate){
                                    addMessage(true);
                                  }


                                },
                                child: Icon(Icons.send_rounded))),
                      ),


                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      //],
      //  ),
      //),
      //  ),
    );
  }





}
