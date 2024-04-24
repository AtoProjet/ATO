import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/actions.dart';
import '../db/references.dart';
import '../sr_screens/login_screen.dart';
import '../widgets/admin_widgets/common_widgets/myBtn1.dart';

class AccountDisabledScreen extends StatefulWidget {
  const AccountDisabledScreen({super.key});

  @override
  State<AccountDisabledScreen> createState() => _AccountDisabledScreenState();
}

class _AccountDisabledScreenState extends State<AccountDisabledScreen> {
  @override

  logout(){
    Fire.auth.signOut().then((value){
      setState(() {
        goToScreenAndClearHistory(context, const LoginScreen());
      });

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 35,

              child: Icon(Icons.warning, size: 65, color: Colors.redAccent)
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Your Account is disabled, Please Contact Customer Support", textAlign: TextAlign.center, style:
            TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 20,

            ),),
          ),
          Gap(10),
          MyBtn1(buttonText: "Go Back",
            onTap: (){
              logout();
            },),



        ],
      ),
    )));


  }
}
