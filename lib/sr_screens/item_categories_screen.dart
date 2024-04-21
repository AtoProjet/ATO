import 'package:ato/components/actions.dart';
import 'package:ato/components/widgets.dart';
import 'package:ato/db/consts.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/sr_screens/add_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCategoriesScreen extends StatefulWidget {
  static Tr title = Tr.categories;

  const ItemCategoriesScreen({super.key});

  @override
  State<ItemCategoriesScreen> createState() => _ItemCategoriesScreenState();
}

class _ItemCategoriesScreenState extends State<ItemCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    return Center(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,120.0),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: [
          ...atoCategoryCardList(loc),
        ],
      ),
    );
  }

  List<Widget> atoCategoryCardList(LocaleProvider loc) {
    List<Widget> catListWid = [];
    for (String cat in categories) {
      catListWid.add(atoCategoryCard(cat, loc));
    }

    return catListWid;
  }

  Card atoCategoryCard(cat, LocaleProvider loc) {
    return Card(
      elevation: 5,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 20),
      child: Container(
        height: 120,
        padding: const EdgeInsetsDirectional.fromSTEB(2, 4, 10, 4),
        width: screenSize(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: cardBackgroundColor,
        ),
        child: Row(
          children: [
            Container(
              height: 110,

              width: screenSize(context).width / 2 - 40,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                image:  assetCategory(name: "$cat.jpg"),
                ),
            ),
            SizedBox(
              height: 90,
              width: screenSize(context).width / 2 - 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    loc.ofStr(cat),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.bottomEnd,
                    height: 32,
                    width: 90,
                    child: atoDarkMaterialButton(
                      onPressed: () {
                        goToScreen(context, AddItemScreen(category: cat));
                      },
                      icon: 'assets/images/ic_add.png',
                        changeIconColor: false,
                      text:
                        loc.of(Tr.add),
                      color: buttonColor
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
