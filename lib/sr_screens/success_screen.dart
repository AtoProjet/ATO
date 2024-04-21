import 'package:ato/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets.dart';

class SuccessScreen extends StatefulWidget {
  Tr message;
  SuccessScreen({super.key, required this.message});
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc= Provider.of(context);
    setAsFullScreen();
    return atoScaffold(
      context: context,
      showAppBar: false,
      showAppBarBackground: false,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/success.png', width: 250, height: 250, ),
                 Text(loc.of(widget.message), style: const TextStyle(color: Colors.blue),),
            ],
          ),
        ),
    );
  }

}
