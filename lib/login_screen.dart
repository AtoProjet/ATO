import 'package:ato/customs/components.dart';
import 'package:ato/db/references.dart';
import 'package:ato/home_screen.dart';
import 'package:ato/tools/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'customs/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =
  TextEditingController(text: "ato.966000@gmail.com");
  final TextEditingController _passwordController =
  TextEditingController(text: "123456");

  String? _error;
  String? _emailError;
  String? _passwordError;
  bool _valid = false;

  _validateInputs() {
    setState(() {
      _emailError = validateEmail(_emailController.text);
      _passwordError = validatePassword(_passwordController.text);
      if (_emailError != null) print(_emailError);
      if (_passwordError != null) print(_passwordError);
      _valid =
          _emailError == null &&
          _passwordError == null;
    });
  }

  login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      UserCredential userCredential = await Fire.auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential.user !=null){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen(title: "")),
        );
      }
      else{
        setState(() {
          _error= "Not Found!";
        });
      }
    } catch (e) {
      setState(() {
        _error= 'Registration Error: $e';
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    setAsFullScreen();
    return Scaffold(
      appBar: getAppBar(context, ""),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12.0),
            TextField(
              controller: _emailController,
              decoration:  InputDecoration(labelText: 'Email Address',
              errorText: _emailError),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration:  InputDecoration(labelText: 'Password',
              errorText: _passwordError),
            ),
            const SizedBox(height: 36.0),
            SizedBox(
              width: 100,
              child: darkMaterialButton(
                onPressed: () async {
                  _validateInputs();
                  if(_valid) {
                    try {
                      login();
                    } catch (e) {
                      _error= e.toString();
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
