import 'package:ato/components/widgets.dart';
import 'package:ato/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String title= "Chat";
  ChatScreen({super.key});


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {

    return atoScaffold(
      context: context,
      showAppBarBackground: false,
      showBottomBar: true,
      title: ChatScreen.title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
               Text(ChatScreen.title),
            ],
          ),
        ),
      ),
    );
  }
}
