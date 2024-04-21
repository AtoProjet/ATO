import 'package:ato/providers/locale_provider.dart';
import 'package:provider/provider.dart';

import 'register_screen.dart';
import 'package:ato/components/actions.dart';
import 'package:flutter/material.dart';

import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets.dart';

class AccountTypeScreen extends StatefulWidget {
   const AccountTypeScreen({super.key});
   static Tr title= Tr.accountType;
  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    setAsFullScreen();

    return atoScaffold(
      title: loc.of(AccountTypeScreen.title),
      context:context,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("${loc.of(Tr.selectAccountType)}:"),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(48.0, 32.0, 48.0, 4.0),
                child: atoDarkMaterialButton(
                  onPressed: () {
                    goToScreen(context, const RegisterScreen(accountType: "Donor"));
                  },
                  text: loc.of(Tr.donor),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(48.0, 16.0, 48.0, 72.0),
                child: atoDarkMaterialButton(
                  onPressed: () {
                    goToScreen(context, const RegisterScreen(accountType: "Beneficiary"));
                  },
                  text:loc.of(Tr.beneficiary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
