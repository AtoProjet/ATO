import 'package:ato/register_screen.dart';
import 'package:flutter/material.dart';

import 'customs/styles.dart';
import 'customs/components.dart';

class AccountTypeScreen extends StatefulWidget {
   const AccountTypeScreen({super.key, required this.title});
  final String title;

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  @override
  Widget build(BuildContext context) {
    setAsFullScreen();

    return Scaffold(
      appBar: getAppBar(context, ""),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select account type:"),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(48.0, 32.0, 48.0, 4.0),
              child: darkMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen(accountType: "Donor")),
                  );
                },
                child: const Text('Donor'),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(48.0, 16.0, 48.0, 72.0),
              child: darkMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RegisterScreen(accountType: "Beneficiary")),
                  );
                },
                child: const Text('Beneficiary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
