import 'package:ato/admin_screens/admin_UserChatsScreen.dart';
import 'package:ato/admin_screens/admin_profile.dart';
import 'package:ato/admin_screens/manage_accounts_screen.dart';
import 'package:ato/admin_screens/sendNotification_screen1.dart';
import 'package:ato/admin_screens/sidebar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/constants.dart';
import '../sr_screens/profile_screen.dart';
import 'eduMaterials_screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedindex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetoptions = <Widget>[
      AdminProfile(),
      ManageAccountsScreen(),
      EduMaterialScreen(),
      SendNotificationPage1(),
      AdminUserChatScreen(),
      SidebarScreen(),
    ];



    return Scaffold(

      body: Center(child: _widgetoptions[_selectedindex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        currentIndex: _selectedindex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,
                  size: 30, color: kBottomNavBarInactiveIconColor),
              activeIcon: Icon(Icons.account_circle,
                  color: kBottomNavBarActiveIconColor, size: 33),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.people,
                  size: 30, color: kBottomNavBarInactiveIconColor),
              activeIcon: Icon(Icons.people,
                  color: kBottomNavBarActiveIconColor, size: 33),
              label: ""),

          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  size: 30, color: kBottomNavBarInactiveIconColor),
              activeIcon: Icon(
                Icons.home,
                color: kBottomNavBarActiveIconColor,
                size: 33,
              ),

              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view,
                  size: 30, color: kBottomNavBarInactiveIconColor),
              activeIcon: Icon(
                Icons.grid_view,
                color: kBottomNavBarActiveIconColor,
                size: 33,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent,
                  size: 30, color: kBottomNavBarInactiveIconColor),
              activeIcon: Icon(
                Icons.support_agent,
                color: kBottomNavBarActiveIconColor,
                size: 33,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.list,
                  size: 30, color: kBottomNavBarInactiveIconColor),
              activeIcon: Icon(
                Icons.list,
                color: kBottomNavBarActiveIconColor,
                size: 33,
              ),
              label: ''),

        ],
      ),
    );
  }
}
