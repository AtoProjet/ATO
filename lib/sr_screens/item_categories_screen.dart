import 'package:ato/components/widgets.dart';
import 'package:ato/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCategoriesScreen extends StatefulWidget {
  static String title= "Item Categories";
  const ItemCategoriesScreen({super.key});

  @override
  State<ItemCategoriesScreen> createState() => _ItemCategoriesScreenState();
}

class _ItemCategoriesScreenState extends State<ItemCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return atoScaffold(
      context: context,
      showAppBarBackground: false,
      showBottomBar: true,

      title: ItemCategoriesScreen.title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
