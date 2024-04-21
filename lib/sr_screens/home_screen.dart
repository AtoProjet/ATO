import 'package:ato/components/widgets.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/cart_screen.dart';
import 'package:ato/sr_screens/chat_screen.dart';
import 'package:ato/sr_screens/item_categories_screen.dart';
import 'package:ato/sr_screens/profile_screen.dart';
import 'package:ato/sr_screens/shopping_screen.dart';
import 'package:ato/sr_screens/slider_screen.dart';
import 'package:ato/sr_screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  List<Widget> screens = [
    const SliderScreen(),
    // if (UserModel.user != null && UserModel.user!.role == "Donor")
     const ItemCategoriesScreen(),
    // if (UserModel.user != null && UserModel.user!.role == "Beneficiary")
      ShoppingScreen(),
    // if (UserModel.user != null && UserModel.user!.role == "Beneficiary")
     const CartScreen(),
    const ChatScreen(),
     const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    final List<BottomNavigationBarItem> buttons= bottomNavigationBarOptions(loc: loc);
    setAsFullScreen(isFullScreen: false);
    return atoScaffold(
        context: context,
        showBackButton: false,
        showAppBarBackground: false,
        bottomBar: BottomNavigationBar(
          currentIndex: currentPage,
          backgroundColor: Colors.blue.shade700,
          items: buttons,
          onTap: (value) {
            setState(() {
              currentPage = value;

            });
          },
        ),
        title: buttons[currentPage].label!,
        body: screens[currentPage]);
  }

}


List<BottomNavigationBarItem> bottomNavigationBarOptions({
  required LocaleProvider loc,
  bool showCart = false,
}) {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: assetIcon(name: "home.png"),
        activeIcon: assetIcon(name: "home-active.png"),
        label: loc.of(SliderScreen.title),
        backgroundColor: Colors.blueGrey),
    // if (UserModel.user != null && UserModel.user!.role == "Donor")
    BottomNavigationBarItem(
        icon: assetIcon(name: "grid.png"),
        activeIcon: assetIcon(name: "grid-active.png"),
        label: loc.of(ItemCategoriesScreen.title),
        backgroundColor: Colors.blueGrey),
    // if (UserModel.user != null && UserModel.user!.role == "Beneficiary")
    BottomNavigationBarItem(
        icon: assetIcon(name: "find.png"),
        activeIcon: assetIcon(name: "find-active.png"),
        label: loc.of(ShoppingScreen.title),
        backgroundColor: Colors.blueGrey),
    // if (UserModel.user != null && UserModel.user!.role == "Beneficiary")
    BottomNavigationBarItem(
        icon: assetIcon(name: "cart.png"),
        activeIcon: assetIcon(name: "cart-active.png"),
        label: loc.of(CartScreen.title),
        backgroundColor: Colors.blueGrey),
    BottomNavigationBarItem(
        icon: assetIcon(name: "chat.png"),
        activeIcon: assetIcon(name: "chat-active.png"),
        label: loc.of(ChatScreen.title),
        backgroundColor: Colors.blueGrey),
    BottomNavigationBarItem(
        icon: assetIcon(name: "profile.png"),
        activeIcon: assetIcon(name: "profile-active.png"),
        label: loc.of(ProfileScreen.title),
        backgroundColor: Colors.blueGrey),
  ];

  return items;
}

