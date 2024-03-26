import 'package:ato/sr_screens/cart_screen.dart';
import 'package:ato/sr_screens/chat_screen.dart';
import 'package:ato/sr_screens/home_screen.dart';
import 'package:ato/sr_screens/item_categories_screen.dart';
import 'package:ato/models/user.dart';
import 'package:ato/sr_screens/profile_screen.dart';
import 'package:ato/sr_screens/shopping_screen.dart';
import 'package:flutter/material.dart';

import 'package:ato/components/actions.dart';

Container atoScaffold({
  required BuildContext context,
  required Widget body,
  String title = "ATO",
  bool showAppBar = true,
  bool showAppBarBackground = true,
  bool showBackButton = true,
  bool showBottomBar = false,
  FloatingActionButton? floatingActionButton,
  dynamic isLoading,
}) {
  return Container(
    color: Colors.white,
    child: Stack(
      children: [
        if (showAppBarBackground)
          const SizedBox(
            width: double.infinity,
            height: 156.0,
            child: Image(
              image: AssetImage('assets/images/header.png'),
              fit: BoxFit.fill,
            ),
          ),
        if (!showAppBarBackground)
          Container(
            alignment: Alignment.bottomRight,
            width: double.infinity,
            height: 120.0,
            child: const SizedBox(
              height: 80,
                child:  Image(
                  image: AssetImage('assets/images/ic_logo.jpg'),
                  fit: BoxFit.contain,
                ),
            ),
          ),
        Padding(
            padding: EdgeInsets.fromLTRB(
                0,
                !showAppBar
                    ? 0
                    : (showAppBar && !showAppBarBackground ? 72 : 36),
                0,
                0),
            child: Scaffold(
              body: body,
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: showBottomBar
                  ? atoBottomNavigationBar(context: context)
                  : null,
              backgroundColor: Colors.transparent,
              appBar: showAppBar
                  ? _atoAppBar(context,
                      title: title, showBackIcon: showBackButton)
                  : null,
            )),
        if (isLoading != null && isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ),
          )
      ],
    ),
  );
}

AppBar _atoAppBar(BuildContext context,
    {String title = "ATO", bool showBackIcon = true}) {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        if (showBackIcon) {
          goBack(context);
        }
      },
      child: showBackIcon
          ? const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
          : const Icon(
              Icons.circle_rounded,
              color: Colors.white60,
            ),
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}


BottomNavigationBar atoBottomNavigationBar({
  required BuildContext context,
  bool showCart = false,
}) {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: const Icon(Icons.home_rounded),
        label: HomeScreen.title,
        backgroundColor: Colors.blueGrey
    ),
    if (UserModel.user!= null && UserModel.user!.role == "Donor")
      BottomNavigationBarItem(
          icon: const Icon(Icons.grid_view_rounded),
          label: ItemCategoriesScreen.title,
          backgroundColor: Colors.blueGrey
      ),
    if (UserModel.user!= null &&UserModel.user!.role == "Beneficiary")
      BottomNavigationBarItem(
          icon: const Icon(Icons.manage_search_rounded),
          label: ShoppingScreen.title,
          backgroundColor: Colors.blueGrey
      ),
    if (UserModel.user!= null && UserModel.user!.role == "Beneficiary")
      BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart_rounded),
          label: CartScreen.title,
          backgroundColor: Colors.blueGrey
      ),
    BottomNavigationBarItem(
        icon: const Icon(Icons.chat_rounded),
        label: ChatScreen.title,
        backgroundColor: Colors.blueGrey
    ),
    BottomNavigationBarItem(
        icon: const Icon(Icons.person_rounded),
        label: ProfileScreen.title,
        backgroundColor: Colors.blueGrey
    ),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    if (UserModel.user!= null && UserModel.user!.role == "Donor") const ItemCategoriesScreen(),
    if (UserModel.user!= null && UserModel.user!.role == "Beneficiary") const ShoppingScreen(),
    if (UserModel.user!= null && UserModel.user!.role == "Beneficiary") const CartScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  return BottomNavigationBar(
    items: items,
    onTap: (value) {
      goToScreen(context, screens[value]);
    },
  );
}


MaterialButton darkMaterialButton({
  required VoidCallback? onPressed,
  required String text,
  double fontSize = 16,
  Color? color,
  bool enabled = true,
}) {
  color ??= const Color.fromRGBO(15, 61, 123, 0.5);
  // color ??= Colors.blueGrey.shade300;
  return MaterialButton(
    onPressed: enabled ? onPressed : null,
    color: color,
    textColor: Colors.white,
    elevation: 2,
    disabledColor: Colors.grey.shade400,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(12),
    child: Text(
      text,
      style: TextStyle(fontSize: fontSize),
    ),
  );
}

MaterialButton lightMaterialButton({
  required onPressed,
  required String text,
  double fontSize = 16,
  Color? color,
  Color? textColor,
  enabled = false,
}) {
  textColor ??= const Color.fromRGBO(15, 61, 123, 1);
  color ??= Colors.grey.shade300;
  return MaterialButton(
    onPressed: enabled ? onPressed : null,
    color: color,
    textColor: textColor,
    elevation: 5,
    disabledColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(12),
    child: Text(
      text,
      style: TextStyle(fontSize: fontSize),
    ),
  );
}

FloatingActionButton FloatingActionButtonAdd({required onPressed}) {
  return FloatingActionButton(
    onPressed: onPressed,
    tooltip: 'Add',
    backgroundColor: const Color.fromRGBO(15, 61, 123, 0.5),
    child: const Icon(Icons.add, color: Colors.white),
  );
}

Stack LoadingStack({required Widget child, required bool isLoading}) {
  return Stack(children: [
    child,
  ]);
}

Center atoProfileImage({String? url, double radius = 48}){
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child:
      url!= null?
      Image.network(
        url,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
      ):
      Image.asset(
      "assets/images/ic_user_female.jpg",
      width: radius * 2,
      height: radius * 2,
      fit: BoxFit.cover,
      ),
    ),
  );

  atoCategoryCard(){

  }
}
