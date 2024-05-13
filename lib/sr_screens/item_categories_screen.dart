import 'package:ato/components/actions.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/components/widgets/images.dart';
import 'package:ato/db/consts.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/sr_screens/add_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/firebaseChatServices.dart';

class ItemCategoriesScreen extends StatefulWidget {
  static Tr title = Tr.categories;

  const ItemCategoriesScreen({super.key});

  @override
  State<ItemCategoriesScreen> createState() => _ItemCategoriesScreenState();
}

List<Map<String, dynamic>> catList = [];
Future<List<Map<String, dynamic>>> getItemCat() async {
  catList = await FirebaseChatServices().getItemCategories();
  print(catList);
  //setState(() {});
  return catList;
}
class _ItemCategoriesScreenState extends State<ItemCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    setAsFullScreen(true);
    LocaleProvider loc = Provider.of(context);
    return Center(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,120.0),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: [

          FutureBuilder<List<Map<String, dynamic>>>(
          future: getItemCat(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) return Text("ERROR: ${snapshot.error}");
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            var data = snapshot.data!;

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {

                  if(data[index]["isView"] == true){
                    return atoCategoryCard(data[index]["catName"], loc);
                  }


                },
              ),
            );

            //   Column(
            //   children: [
            //     ...atoCategoryCardList(loc, data)
            //   ],
            // );

          })


        ],
      ),
    );
  }

  // List<Widget> atoCategoryCardList(LocaleProvider loc,List<Map<String, dynamic>> data) {
  //   List<Widget> catListWid = [];
  //
  //   //for (String cat in categories) {
  //   for (String dat in data) {
  //
  //     catListWid.add(atoCategoryCard(dat[""], loc));
  //   }
  //
  //   return catListWid;
  // }

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
                image:  atoAssetOfCategory("$cat.jpg"),
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
                    height: 28,
                    width: 120,
                    child: atoIconTextMaterialButton(
                      onPressed: () {
                        goToScreen(context, AddItemScreen(category: cat));
                      },
                        fontSize: 13,
                      icon: 'assets/images/ic_add.png',
                        changeIconColor: false,
                      text:
                        loc.of(Tr.add),
                      color: buttonColor.withAlpha(50)
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
