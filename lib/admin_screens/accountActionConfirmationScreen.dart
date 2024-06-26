import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/admin_widgets/common_widgets/myBtn1.dart';
import 'admin_home.dart';

class AccountActionConfirmation extends StatelessWidget {
  final String action;
  const AccountActionConfirmation({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 35,
        
                  child: Icon(Icons.done, size: 55, color: Colors.white)
              ),
              Gap(20),
              Text("User Account "+action+" Successfully", style:
              TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
              Gap(25),
              MyBtn1(buttonText: "OK",
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => AdminHome()));
                },)
        
        
            ],
          ),
        ),
      ),
    );
  }
}
