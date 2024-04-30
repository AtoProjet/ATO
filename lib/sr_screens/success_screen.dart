import 'package:ato/components/actions.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/home_screen.dart';
import 'package:ato/sr_screens/item_categories_screen.dart';
import 'package:ato/sr_screens/shopping_screen.dart';
import 'package:gap/gap.dart';
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
      showBackButton: false,
      showAppBarBackground: false,
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/success.png', width: 250, height: 250, ),
                 Text(loc.of(widget.message), style:  TextStyle(color: Colors.cyan.shade500, fontSize: 18),),
              const Gap(100),
              atoDarkMaterialButton(
                  // color: Colors.cyan.shade800,
                  onPressed: (){
                goToScreenAndClearHistory(context,
                    HomeScreen(startScreenTitle: UserModel.isBeneficiary()? ShoppingScreen.title: ItemCategoriesScreen.title ));},
                  text: loc.of(Tr.goToHome))
            ],
          ),
        ),
    );
  }

}
