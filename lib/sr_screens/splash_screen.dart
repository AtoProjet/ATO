import 'package:ato/providers/locale_provider.dart';
import 'package:ato/db/references.dart';
import 'package:provider/provider.dart';
import '../admin_screens/account_disabled_screen.dart';
import '../admin_screens/admin_home.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'account_type_screen.dart';
import 'package:ato/models/user.dart';
import 'package:ato/components/actions.dart';
import 'verification_code_screen.dart';
import 'package:flutter/material.dart';

import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  final Tr title = Tr.appName;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    setAsFullScreen();
    return atoScaffold(
      context: context,
      showAppBar: false,
      isLoading: _isLoading,
      body: Container(
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
              if (!_isLoading && UserModel.user == null)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(48.0, 8.0, 48.0, 4.0),
                  child: atoDarkMaterialButton(
                    onPressed: () {
                      goToScreen(context, const AccountTypeScreen());
                    },
                    text: loc.of(Tr.iAmNewUser),
                  ),
                ),
              if (!_isLoading && UserModel.user == null)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(48.0, 4.0, 48.0, 72.0),
                  child: atoDarkMaterialButton(
                    onPressed: () {
                      goToScreen(context, const LoginScreen());
                    },
                    text: loc.of(Tr.iHaveAnAccount),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUser() {
    if (Fire.auth.currentUser != null) {
      Fire.auth.currentUser!.reload().then((_) {
        if (Fire.auth.currentUser != null) {
          Fire.userRef.doc(Fire.auth.currentUser!.uid).get().then((doc) async {
            if (doc.exists) {
              var data = doc.data();
              setState(() {
                UserModel.user =
                    UserModel.fromJson(data as Map<String, dynamic>);
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
                        goToScreenAndClearHistory(context, const HomeScreen());
                      }
                    }
                    //goToScreen(context, const HomeScreen());
                  } else {
                    goToScreen(context, const VerificationCodeScreen());
                  }
              });
            }
            else {
                setState(() {
                  _isLoading = false;
                });
            }
          });
        }
        else {
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
        _isLoading = false;
      });
    }
  }
}
