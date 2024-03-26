import 'package:ato/components/styles.dart';
import 'package:ato/db/references.dart';
import 'home_screen.dart';
import 'package:ato/components/actions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/widgets.dart';

class VerificationCodeScreen extends StatefulWidget {
  static String title = "Verification Code";
  const VerificationCodeScreen({super.key});
  @override
  createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  User user = Fire.auth.currentUser!;
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  String _msg = "";
  String _error="";
  bool _verified = false;
  bool _isLauding= false;

  @override
  void initState() {
    _verified = user.emailVerified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _msg = 'A verification email has been sent to "${user.email}", '
        'Please, check your email and click on verification link.';
    return atoScaffold(
      showBackButton: false,
      isLoading: _isLauding,
      context: context,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
                width: double.infinity,
                child: Text("Check Your Email", style: headerStyle())),
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
                  _verified ? "Verified" : "Not Verified",
                  style: headerStyle(
                      fontSize: 24, color: _verified ? Colors.green : Colors.red),
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            darkMaterialButton(onPressed: () async{
              setState(() {
                _isLauding= true;
              });
              await Fire.auth.currentUser!.reload();
              user= Fire.auth.currentUser!;
              setState(() {
                _verified= user.emailVerified;
                _isLauding= false;
              });
            }, text: "Check Status!",
            enabled: !_verified),
            const SizedBox(height: 20),
            darkMaterialButton(onPressed: (){
              goToScreen(context, const HomeScreen());
            },enabled: _verified,
                text: "Go To Home"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Didn\'t receive code?'),
                TextButton(
                  onPressed: () {
                    _resendVerificationEmail();
                  },
                  child: const Text('Resend'),
                ),
              ],
            ),
              Text(_error, style: const TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }

  void _resendVerificationEmail() {
    if (!user.emailVerified) {
      setState(() {
        _isLauding= true;
      });

      user.sendEmailVerification().then((_) {
        setState(() {
          _msg = "A new Verification email has been sent to ${user.email}!";
          _error = "";
          _isLauding= false;
        });
      }).catchError((error) {
        setState(() {
          _error = 'Failed to resend verification email: $error';
        });
      });
    }
  }
}
