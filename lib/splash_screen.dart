import 'package:ato/login_screen.dart';
import 'package:ato/account_type_screen.dart';
import 'package:flutter/material.dart';

import 'customs/styles.dart';
import 'customs/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});
  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    setAsFullScreen();
    return Scaffold(
      body:
      Container(
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(48.0, 8.0, 48.0, 4.0),
                child: darkMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountTypeScreen(title: "Account Type")),
                    );
                  },
                  color: Colors.indigo,
                  child: const Text('I am a new user'),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(48.0, 4.0, 48.0, 72.0),
                child: darkMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  color: Colors.indigo,
                  child: const Text('I have an Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
