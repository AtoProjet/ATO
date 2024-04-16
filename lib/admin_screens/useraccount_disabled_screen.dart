import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/admin_widgets/common_widgets/myBtn1.dart';

class UserAccountDisabledScreen extends StatelessWidget {
  const UserAccountDisabledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 35,

              child: Icon(Icons.done, size: 55, color: Colors.white)
          ),
          Gap(20),
          Text("User Account Disabled Successfully", style:
          TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),),
          Gap(25),
          MyBtn1(buttonText: "OK",
            onTap: (){
            Navigator.pop(context);
            },)


        ],
      ),
    );
  }
}
