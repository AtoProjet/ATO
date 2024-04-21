import 'package:ato/components/widgets.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static Tr title= Tr.chat;
  const ChatScreen({super.key});


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
               Text( loc.of(ChatScreen.title)),
            ],
          ),
      ),
    );
  }
}
