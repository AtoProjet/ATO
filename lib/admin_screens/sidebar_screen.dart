import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/navigationbars.dart';

class SidebarScreen extends StatelessWidget {
  const SidebarScreen({super.key});
  void navigationBarTapped(){
  }
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
        
              children: [
                Gap(55),
                NavigationBars(barText: loc.of(Tr.logout), iconvalue: 0xe3b3, onPress: (){
                  navigationBarTapped();
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
                NavigationBars(barText: loc.of(Tr.itemsCategory), iconvalue: 0xe2ea, onPress: (){
                  navigationBarTapped();
        
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
                NavigationBars(barText: loc.of(Tr.donatedItems), iconvalue: 0xe15b, onPress: (){
                  navigationBarTapped();
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
                NavigationBars(barText: loc.of(Tr.manageAccounts), iconvalue: 0xe3c6, onPress: () {
                  navigationBarTapped();
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
        
        
        
              ],
            )
          ],
        ),
      ),
    );
  }
}
