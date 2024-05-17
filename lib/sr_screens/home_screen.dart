import 'package:ato/components/widgets/global.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/images.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/cart_screen.dart';
import 'package:ato/sr_screens/chat_screen.dart';
import 'package:ato/sr_screens/item_categories_screen.dart';
import 'package:ato/sr_screens/profile_screen.dart';
import 'package:ato/sr_screens/shopping_screen.dart';
import 'package:ato/sr_screens/slider_screen.dart';
import 'package:ato/sr_screens/success_screen.dart';
import 'package:ato/sr_screens/user_chatList_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  Tr? startScreenTitle;
  HomeScreen({super.key, this.startScreenTitle});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 List<Tr> bottomNavIndexes = [
  SliderScreen.title,
   if(UserModel.isDonor())
  ItemCategoriesScreen.title,
   if(UserModel.isBeneficiary())
  ShoppingScreen.title,
   if(UserModel.isBeneficiary())
  CartScreen.title,
  ChatScreen.title,
  ProfileScreen.title,
];

class _HomeScreenState extends State<HomeScreen> {
  int currentPage= 0;

  List<Widget> screens = [
    const SliderScreen(),
    if(UserModel.isDonor())
    const ItemCategoriesScreen(),
    if(UserModel.isBeneficiary())
    const ShoppingScreen(),
    if(UserModel.isBeneficiary())
    const CartScreen(),
    const UserChatListPage(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    currentPage=bottomNavIndexes.indexOf(widget.startScreenTitle?? SliderScreen.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    final List<BottomNavigationBarItem> buttons= bottomNavigationBarOptions(loc: loc);
    setAsFullScreen(true);
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
        icon: atoAssetOfIcon("home.png"),
        activeIcon: atoAssetOfIcon("home-active.png"),
        label: loc.of(SliderScreen.title),
        backgroundColor: Colors.blueGrey),
    if(UserModel.isDonor())
    BottomNavigationBarItem(
        icon: atoAssetOfIcon("grid.png"),
        activeIcon: atoAssetOfIcon( "grid-active.png"),
        label: loc.of(ItemCategoriesScreen.title),
        backgroundColor: Colors.blueGrey),
    if(UserModel.isBeneficiary())
    BottomNavigationBarItem(
        icon: atoAssetOfIcon("find.png"),
        activeIcon: atoAssetOfIcon("find-active.png"),
        label: loc.of(ShoppingScreen.title),
        backgroundColor: Colors.blueGrey),
    if(UserModel.isBeneficiary())
    BottomNavigationBarItem(
        icon: atoAssetOfIcon("cart.png"),
        activeIcon: atoAssetOfIcon("cart-active.png"),
        label: loc.of(CartScreen.title),
        backgroundColor: Colors.blueGrey),
    BottomNavigationBarItem(
        icon: atoAssetOfIcon("chat.png"),
        activeIcon: atoAssetOfIcon("chat-active.png"),
        label: loc.of(ChatScreen.title),
        backgroundColor: Colors.blueGrey),
    BottomNavigationBarItem(
        icon: atoAssetOfIcon("profile.png"),
        activeIcon: atoAssetOfIcon("profile-active.png"),
        label: loc.of(ProfileScreen.title),
        backgroundColor: Colors.blueGrey),
  ];

  return items;
}

