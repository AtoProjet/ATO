import 'package:ato/components/tools.dart';
import 'package:ato/db/firebaseChatServices.dart';
import 'package:ato/sr_screens/chat_support_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatefulWidget {
  final String myuserid, lastMessage, chatRoomId, time;
  const ChatListTile({super.key, required this.lastMessage, required this.chatRoomId, required this.time, required this.myuserid});

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
bool isAdmin = false;
  String profilePicUrl = "", name="", user2id = "", id="", Usrname= "";

  Future<String> getUserInfo()async {
    user2id = widget.chatRoomId.replaceAll("_", "").replaceAll(widget.myuserid, "");
    QuerySnapshot querySnapshot = await FirebaseChatServices().getUserInfo(user2id);
    final aname = "${querySnapshot.docs[0]["name"]}";
    if(aname is String){
      Usrname = aname;
    }
    if(querySnapshot.docs[0]["role"] == "Admin"){
      isAdmin = true;
    }
    return Usrname;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        print("Starting the function to create chatroom");
        //String myUsername = "ayazanjum15";

        var chatRoomId =
        getChatRoomIdById(widget.myuserid, user2id);
        print("Chat Room id is "+ chatRoomId);
        //print("Creating chatRoomInfoMap");

        Map<String, dynamic> chatRoomInfoMap = {
          "users": [widget.myuserid, user2id ],
        };
        print("Triggering Database methods");

        await FirebaseChatServices()
            .createChatRoom(chatRoomId, chatRoomInfoMap);
        print("Completed");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatSupportScreen(
                  name: name, userId2: user2id, )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Icon(Icons.account_circle, size: 60,),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 10),
                FutureBuilder<String>(
                  future: getUserInfo(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasError) return Text("ERROR: ${snapshot.error}");
                    if (!snapshot.hasData) return CircularProgressIndicator();

                    var data = snapshot.data;
                    print (" the 9999 data is ");
                    print (data);
                    return  Column(
                      children: [
                        if(isAdmin)
                          Text("ATO Admin", style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),),
                        if(!isAdmin)
                          Text(data!, style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),),
                      ],
                    );
                  }),

                Container(
                  width: MediaQuery.of(context).size.width *0.5,
                  child: Text(widget.lastMessage, style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,

                      overflow:  TextOverflow.ellipsis

                  ),),
                )

              ],
            ),
            Spacer(),
            Text(widget.time, style: TextStyle(
                color: Colors.black45,
                fontSize: 14,
                fontWeight: FontWeight.w500
            ),)
          ],
        ),
      ),
    );

  }
}
