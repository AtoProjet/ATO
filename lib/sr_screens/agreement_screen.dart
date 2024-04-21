import 'package:ato/components/actions.dart';
import 'package:ato/db/consts.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/locale_provider.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  static Tr title = Tr.termsAndConditions;

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    return atoScaffold(
      title: loc.of(AgreementScreen.title),
      context: context,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 64.0, 24.0, 24.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "${loc.of(Tr.termsAndConditions)}:",
                style: headerStyle(),
              ),
            ),
            const Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                conditions1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: Text(
                "${loc.of(Tr.withATO)}:",
                style: headerStyle(),
              ),
            ),
            const Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                conditions2,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Divider(),
            const SizedBox(height: 24),
            Center(
              child: atoDarkMaterialButton(onPressed: (){
                goBack(context);
              }, text: loc.of(Tr.goBackToRegister)),
            ),
            const SizedBox(height: 48),

          ],
        ),
      ),
    );
  }
}
