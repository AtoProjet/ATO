import 'package:ato/components/actions.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/home_screen.dart';
import 'package:ato/sr_screens/shopping_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/global.dart';

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
    setAsFullScreen(true);
    return atoScaffold(
      context: context,
      showAppBar: true,
      showAppBarBackground: false,
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/success.png', width: 250, height: 250, ),
                 Text(loc.of(widget.message), style: const TextStyle(color: Colors.blue),),
              atoDarkMaterialButton(onPressed: (){goToScreenAndClearHistory(context, HomeScreen(startScreenTitle: ShoppingScreen.title,));}, text: loc.of(Tr.goToHome))
            ],
          ),
        ),
    );
  }

}
