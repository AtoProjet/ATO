import 'package:ato/admin_screens/account_disabled_screen.dart';
import 'package:ato/admin_screens/admin_home.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/sr_screens/account_type_screen.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/db/references.dart';
import 'home_screen.dart';
import 'package:ato/models/user.dart';
import 'package:ato/components/actions.dart';
import 'package:ato/db/validator.dart';
import 'verification_code_screen.dart';
import 'package:flutter/material.dart';

import 'package:ato/components/styles.dart';

class LoginScreen extends StatefulWidget {
  static String title = "Login";

  const LoginScreen({super.key});

  @override
  createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _error;
  String? _emailError;
  String? _passwordError;
  bool _valid = false;
  bool _isLoading = false;

  bool addTest = true;

  @override
  Widget build(BuildContext context) {
    if (addTest) {
      setState(() {
        // _emailController.text = "ato.966000@gmail.com";
        // _passwordController.text = "123456";


        // _emailController.text = "ayazanjum15@gmail.com";
        // _passwordController.text = "123456";


      });
    }
    setAsFullScreen(true);
    return atoScaffold(
      title: LoginScreen.title,
      isLoading: _isLoading,
      context: context,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(48.0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailError,
                  hintText: "you@email.com"),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordError,
                  hintText: "Text contains 6 letters or more"),
            ),
            const SizedBox(height: 36.0),
            Center(
              child: SizedBox(
                width: 100,
                child: atoDarkMaterialButton(
                  onPressed: () async {
                    _validateInputs();
                    if (_valid) {
                      try {
                        login();
                      } catch (e) {
                        _error = e.toString();
                      }
                    }
                  },
                  text: 'Login',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    goToScreen(context, const AccountTypeScreen());
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _validateInputs() {
    setState(() {
      _emailError = validateEmail(_emailController.text);
      _passwordError = validatePassword(_passwordController.text);
      _valid = _emailError == null && _passwordError == null;
    });
  }

  login() {
    setState(() {
      _isLoading = true;
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      Fire.auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCredential) {
        _isLoading = false;
        if (userCredential.user != null) {
          loadUser();
        } else {
          setState(() {
            _isLoading = false;
            _error = "Not Found!";
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Registration Error: $e';
      });
    }
  }

  void loadUser() {
    print("Check User");
    if (Fire.auth.currentUser != null) {
      Fire.auth.currentUser!.reload().then((_) {

        if (Fire.auth.currentUser != null) {

          print("The uid is " + Fire.auth.currentUser!.uid);
          Fire.userRef.doc(Fire.auth.currentUser!.uid).get().then((doc) async {
            setState(() {
              _isLoading = false;
            });
            if (doc.exists) {
              var data = doc.data();
              setState(() {
                print ("setting the user model");
                UserModel.user =
                    UserModel.fromJson(data as Map<String, dynamic>);
                print ("set successgful");
                print("User Role " + UserModel.user!.role);
                if (Fire.auth.currentUser!.emailVerified) {
                  print ("set successgful");

                  if(UserModel.user!.role == "Admin"){
                    goToScreenAndClearHistory(context, const AdminHome());
                  }
                  else{
                    // check if the user account isActive is false, Admin has disabled the account
                    if(UserModel.user!.isActive == false){
                      goToScreenAndClearHistory(context, const AccountDisabledScreen());
                    }
                    else{
                      goToScreenAndClearHistory(context, HomeScreen());
                    }

                  }
                }
                else {
                  goToScreenAndClearHistory(context, const VerificationCodeScreen());
                }
              });
            }
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    else {
      setState(() {
        print(" The Fire Auth current user was null");
        _isLoading = false;
      });
    }
  }
}
