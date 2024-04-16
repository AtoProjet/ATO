import 'package:flutter/material.dart';

class AccountDisabledScreen extends StatelessWidget {
  const AccountDisabledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Text("Your Account is disabled, Please Contact Customer Support"),
    )));
  }
}
