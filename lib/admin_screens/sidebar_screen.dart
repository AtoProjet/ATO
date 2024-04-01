import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/admin_widgets/common_widgets/navigationbars.dart';

class SidebarScreen extends StatelessWidget {
  const SidebarScreen({super.key});
  void navigationBarTapped(){
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
        
              children: [
                Gap(55),
                NavigationBars(barText: 'Logout', iconvalue: 0xe3b3, onPress: (){
                  navigationBarTapped();
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
                NavigationBars(barText: 'Items Category', iconvalue: 0xe2ea, onPress: (){
                  navigationBarTapped();
        
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
                NavigationBars(barText: 'Donated Items', iconvalue: 0xe15b, onPress: (){
                  navigationBarTapped();
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
                NavigationBars(barText: 'Manage Accounts', iconvalue: 0xe3c6, onPress: () {
                  navigationBarTapped();
                },),
                Divider(thickness: 0.5,
                  color: Colors.grey[400],),
                NavigationBars(barText: 'Chat App', iconvalue: 0xe153, onPress: () {
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
