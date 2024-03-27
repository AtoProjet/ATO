import 'package:ato/components/actions.dart';
import 'package:ato/components/consts.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  static String title = "Terms and Conditions";

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return atoScaffold(
      title: AgreementScreen.title,
      context: context,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 64.0, 24.0, 24.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Terms:',
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
                'Conditions:',
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
              child: darkMaterialButton(onPressed: (){
                goBack(context);
              }, text: "Go back To Register"),
            ),
            const SizedBox(height: 48),

          ],
        ),
      ),
    );
  }
}
