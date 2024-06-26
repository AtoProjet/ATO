import 'package:ato/admin_screens/admin_home.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/account_type_screen.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/db/references.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../admin_screens/account_disabled_screen.dart';
import 'home_screen.dart';
import 'package:ato/models/user.dart';
import 'package:ato/components/actions.dart';
import 'package:ato/db/validator.dart';
import 'verification_code_screen.dart';
import 'package:flutter/material.dart';

import 'package:ato/components/styles.dart';

class LoginScreen extends StatefulWidget {
  static Tr title = Tr.login;

  const LoginScreen({super.key});

  @override
  createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  // final TextEditingController _emailController = TextEditingController(text: "ato.966000@gmail.com");
  // final TextEditingController _passwordController = TextEditingController(text: "123456");

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _error;
  String? _emailError;
  String? _passwordError;
  bool _valid = false;
  bool _isLoading = false;
  bool addTest = true;
  @override
  void initState() {
    UserModel.user= null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    setAsFullScreen(true);
    return atoScaffold(
      title: loc.of(LoginScreen.title),
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
                  labelText: loc.of(Tr.email),
                  errorText: _emailError,
                  hintText: "you@email.com"),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: loc.of(Tr.password),
                  errorText: _passwordError,
                  hintText: loc.of(Tr.textContains6lettersOrMore),
            ),
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
                        login(loc);
                      } catch (e) {
                        _error = e.toString();
                      }
                    }
                  },
                  text: loc.of(Tr.login),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //alignment: WrapAlignment.center,
              children: [
                 Text(loc.of(Tr.youDontHaveAnAccount), ),
                TextButton(
                  onPressed: () {
                    goToScreen(context, const AccountTypeScreen());
                  },
                  child:  Text(loc.of(Tr.register)),
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

  login(LocaleProvider loc) async{
    setState(() {
      _isLoading = true;
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential result =  await auth.signInWithEmailAndPassword(email: email, password: password);

      // var res  = Fire.auth
      //     .signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // )
      //     .then((userCredential) {
      //   print ("this is 1");
      //   _isLoading = false;
      //   if (userCredential.user != null) {
      //     loadUser();
      //   } else {
      //     print ("this is 2");
      //     setState(() {
      //       _isLoading = false;
      //       _error = loc.of(Tr.notFound);
      //     });
      //   }
      // });
      if(result != null){
        print("res is null");
        _isLoading = false;
        loadUser();
      }



    } catch (e) {
      setState(() {
        //print ("this is 3");
        _isLoading = false;
        var snackBar = SnackBar(
          content: Text( loc.of(Tr.invalidCredential)),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);

        //_error = '${loc.of(Tr.registrationError)}: $e';
      });
    }
  }

  void loadUser() {
    print("Check User");
    if (Fire.auth.currentUser != null) {
      Fire.auth.currentUser!.reload().then((_) {
        if (Fire.auth.currentUser != null) {
          Fire.userRef.doc(Fire.auth.currentUser!.uid).get().then((doc) async {
            setState(() {
              _isLoading = false;
            });
            if (doc.exists) {
              var data = doc.data();
              setState(() {
                UserModel.user =
                    UserModel.fromJson(data as Map<String, dynamic>);
                print("User Role " + UserModel.user!.role);
                if (Fire.auth.currentUser!.emailVerified) {

                  if(UserModel.user!.role == "Admin"){
                    goToScreenAndClearHistory(context, const AdminHome());
                  }
                  else{
                    // check if the user account isActive is false, Admin has disabled the account
                    if(UserModel.user!.isActive == false){
                      goToScreenAndClearHistory(context, const AccountDisabledScreen());
                    }
                    else{
                      goToScreenAndClearHistory(context,  HomeScreen());
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
    } else {
      setState(() {

        _isLoading = false;

      });
    }
  }
}
