import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/db/references.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OldVerificationCodeScreen extends StatefulWidget {
  static Tr title= Tr.verificationCode;

  const OldVerificationCodeScreen({super.key});
  @override
  createState() => _OldVerificationCodeScreenState();
}

class _OldVerificationCodeScreenState extends State<OldVerificationCodeScreen> {

  User user = Fire.auth!.currentUser!;
  List<TextEditingController> controllers =
  List.generate(5, (index) => TextEditingController());
  bool isError = false;
  String _msg = "";
  String? _error;

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    _msg = 'Verification email sent to ${user.email}';
    return atoScaffold(
      title: loc.of(OldVerificationCodeScreen.title),
      context: context,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                child: Text("Check Your Email", style: headerStyle())),
            Text(_msg,
                style: const TextStyle(fontWeight: FontWeight.w700,
                    color: Colors.grey,
                    fontSize: 18)),
            const SizedBox(height: 24),

            if (_error != null)
              SizedBox(height: 24,
                  child: Text(
                      _error!, style: const TextStyle(color: Colors.red))),
            if (_error == null)
              const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => _buildInputField(index)),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 48,
              child: atoDarkMaterialButton(
                onPressed: _verifyCode,
                text: 'Verify Code',
              ),
            ),
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

          ],
        ),
      ),
    );
  }

  Widget _buildInputField(int index) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextField(
        controller: controllers[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isError ? Colors.red : Theme
                  .of(context)
                  .dividerColor,
            ),
          ),
          counterText: '',
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  void _verifyCode() {
    // TODO FIX THIS CODE
    String dbCode = "8888";
    String code = '';
    for (int i = 0; i < 5; i++) {
      code += controllers[i].text;
    }
    if (code.isEmpty || code != dbCode) {
      setState(() {
        isError = true;
      });
    }
    else {
      setState(() {
        isError = false;
      });
    }
  }


  void _resendVerificationEmail() {
    if (!user.emailVerified) {
      user.sendEmailVerification().then((_) {
        setState(() {
          _msg= "A new Verification email has been sent to ${user.email}!";
          _error = null;
        });
      }).catchError((error) {
        setState(() {
          _error = 'Failed to resend verification email: $error';
        });
      });
    }
  }
}
