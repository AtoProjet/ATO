import 'package:ato/components/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});
  static String title= "Terms and Conditions";

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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    'TTTTTTTTT',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonAdd(
        onPressed: {},
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
