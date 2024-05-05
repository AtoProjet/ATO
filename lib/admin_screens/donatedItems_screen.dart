
import 'package:ato/widgets/admin_widgets/common_widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/actions.dart';
import '../components/app_layout.dart';
import '../components/constants.dart';
import '../components/styles.dart';
import '../components/widgets/images.dart';
import '../db/consts.dart';
import '../db/firebaseChatServices.dart';
import '../models/cloth_item.dart';
import '../models/item.dart';
import '../providers/cart_provider.dart';
import '../providers/item_provider.dart';
import '../providers/locale_provider.dart';
import '../sr_screens/item_info_screen.dart';
import '../widgets/admin_widgets/common_widgets/itemCard.dart';

class DonatedItemsPage extends StatefulWidget {
  const DonatedItemsPage({super.key});

  @override
  State<DonatedItemsPage> createState() => _DonatedItemsPageState();
}

class _DonatedItemsPageState extends State<DonatedItemsPage> {
  final List<bool> _selectedCategories = [true, true, true, true];
  final List<bool> _selectedGenders = [true, true, true];
  final List<bool> _selectedSizes = [true, true, true, true, true];
  List<ItemModel> items = List.empty(growable: true);



  Future<List<ItemModel>> getArticleInfo(String usrId) async {
    items =  await FirebaseChatServices().getUserDonatedItems(usrId);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    //ItemProvider ipo = Provider.of(context);
    LocaleProvider loc = Provider.of(context);

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Topbar(
              isBack: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Gap(0),

            FutureBuilder<List<ItemModel>>(
                future: getArticleInfo("hgXibmqmGUNlzrBDyQmWiPhHzOn1"),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ItemModel>> snapshot) {
                  if (snapshot.hasError)
                    return Text("ERROR: ${snapshot.error}");
                  if (!snapshot.hasData)
                    return Center(
                        child: CircularProgressIndicator());

                  var data = snapshot.data;
                  return Container(
                    height : size.height * 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Stack(
                          children: [
                            GridView(
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                mainAxisExtent: 140,
                              ),
                              // shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                for (ItemModel item in data!)
                                  showItemCard(item, loc),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),



            // Container(
            //   height : size.height * 1,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Center(
            //       child: Stack(
            //         children: [
            //           GridView(
            //             gridDelegate:
            //             const SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2,
            //               crossAxisSpacing: 10.0,
            //               mainAxisSpacing: 10.0,
            //               mainAxisExtent: 140,
            //             ),
            //             // shrinkWrap: true,
            //             scrollDirection: Axis.vertical,
            //             children: [
            //               for (ItemModel item in items)
            //                 showItemCard(item, loc),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),


            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20,0,3,3),
            //   child: Text('Donated Items', style: kLabelEduMaterialsH_font,),
            // ),
            // Gap(5),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // this is the item card where all the items details are contained.
            //     ItemCard(img: 'bag', itemNo: '123456', itemName: 'Medium Gray and Gold Handbag', itemSize: 'L',),
            //     Gap(2),
            //     ItemCard(img: 'jeans', itemNo: '123456', itemName: 'Womens Medium Blue Jeans', itemSize: '40',),
            //
            //   ],
            // ),
            // Gap(7),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //
            //     ItemCard(img: 'shoes', itemNo: '123456', itemName: 'Unisex Sneakers', itemSize: '38',),
            //     Gap(2),
            //     ItemCard(img: 'hoody', itemNo: '123456', itemName: 'Hooded Bluish Gray For Men', itemSize: '40',),
            //
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget showItemCard(ItemModel item, LocaleProvider loc) {
    int catIndex = categories.indexOf(item.category);
    if (!_selectedCategories[catIndex]) {
      return const SizedBox(
        height: 0,
      );
    }
    if (item is ClothModel) {
      int genderIndex = genders.indexOf(item.forGender);
      int sizeIndex = sizes.indexOf(item.size);
      if (!_selectedGenders[genderIndex] || !_selectedSizes[sizeIndex]) {
        return const SizedBox(
          height: 0,
        );
      }
    }
    return atoItemCard(context, item, loc);
  }
}

atoItemCard(BuildContext context, ItemModel item,
    LocaleProvider loc) {
  String text = item.name;
  return Card(
    color: cardBackgroundColor,
    shape: ShapeBorder.lerp(LinearBorder.none, LinearBorder.none, 0),
    child: Stack(children: [
      Container(
        alignment: Alignment.topCenter,
        width: 200,
        child: IconButton(
          onPressed: () {
            goToScreen(context, ItemInfoScreen(item: item));
          },
          icon: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: atoNetworkImage(
                item.image,
                height: 100,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(
            right: loc.isAr() ? 24 : 0, left: loc.isAr() ? 0 : 24),
        child: Text(
          maxLines: 1,
          text,
          style: const TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      if (item is ClothModel)
        Container(
          padding: const EdgeInsets.all(4),
          alignment: Alignment.topLeft,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: Color(item.color),
                border: const Border.fromBorderSide(
                    BorderSide(width: 1, color: Colors.grey)),
                borderRadius: BorderRadius.circular(2)),
          ),
        ),
    ]),
  );
}
