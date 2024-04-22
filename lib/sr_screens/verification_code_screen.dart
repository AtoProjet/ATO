import 'package:ato/components/styles.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/account_type_screen.dart';
import 'package:ato/sr_screens/login_screen.dart';
import 'package:ato/sr_screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'package:ato/components/actions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/widgets.dart';

class VerificationCodeScreen extends StatefulWidget {
  static Tr title= Tr.verificationCode;
  const VerificationCodeScreen({super.key});
  @override
  createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  User user = Fire.auth.currentUser!;
  List<TextEditingController> controllers =
  List.generate(5, (index) => TextEditingController());
  String _msg = "";
  String _error = "";
  bool _verified = false;
  bool _isLauding = false;

  @override
  void initState() {
    _verified = user.emailVerified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    _msg = 'A verification email has been sent to "${user.email}", '
        'Please, check your email and click on verification link.';
    return atoScaffold(
      showBackButton: false,
      isLoading: _isLauding,
      context: context,
      body: ListView(
        padding: const EdgeInsets.all(48.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        children: [
          const SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              child: Text(loc.of(Tr.checkYourEmail), style: headerStyle())),
          SizedBox(
            width: double.infinity,
            child: Text(_msg,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                    fontSize: 16)),
          ),
          const SizedBox(height: 20),
          const Divider(),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                _verified ? loc.of(Tr.verified) : loc.of(Tr.notVerified),
                style: headerStyle(
                    fontSize: 24,
                    color: _verified ? Colors.green : Colors.red),
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          atoDarkMaterialButton(onPressed: () async {
            setState(() {
              _isLauding = true;
            });
            await Fire.auth.currentUser!.reload();
            user = Fire.auth.currentUser!;
            setState(() {
              _verified = user.emailVerified;
              _isLauding = false;
            });
          }, text: loc.of(Tr.checkStatus),
              enabled: !_verified),
          const SizedBox(height: 20),
          atoDarkMaterialButton(onPressed: () {
            goToScreen(context, const HomeScreen());
          }, enabled: _verified,
              text: loc.of(Tr.goToHome)),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              logout();
            },
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout_outlined,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  loc.of(Tr.useAnotherAccount),
                  style: const TextStyle(
                      fontSize: 16,),
                ),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
               Text(loc.of(Tr.didNotReceiveCode),
          style: const TextStyle(
            fontSize: 16,),

            ),
              TextButton(
                onPressed: () {
                  _resendVerificationEmail(loc);
                },
                child: Text(loc.of(Tr.resend),
                  style: const TextStyle(
                    fontSize: 16,),

                ),
              ),
            ],
          ),

          Text(_error, style: const TextStyle(color: Colors.red),)
        ],
      ),
    );
  }

  void _resendVerificationEmail(LocaleProvider loc) {
    if (!user.emailVerified) {
      setState(() {
        _isLauding = true;
      });

      user.sendEmailVerification().then((_) {
        setState(() {
          _msg = "${loc.of(Tr.aNewVerificationEmailHasBeenSentTo)} ${user.email}!";
          _error = "";
          _isLauding = false;
        });
      }).catchError((error) {
        setState(() {
          _error = "${loc.of(Tr.failedToResendVerificationEmail)}: $error";
        });
      });
    }
  }

  logout() {
    Fire.auth.signOut().then((value) {
      setState(() {
        UserModel.user = null;
        goToScreenAndClearHistory(context, const AccountTypeScreen());
      });
    });
  }

}
