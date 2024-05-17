import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/app_layout.dart';
import '../../../components/constants.dart';
import '../../../components/widgets/images.dart';
import '../../../sr_screens/item_info_screen.dart';
import '../btnWidgets/removeBtn.dart';

class ItemCard extends StatelessWidget {
  final String img;
  final String itemNo;
  final String itemName;
  final String itemDetails;
  final Function() removeOnTap;
  const ItemCard({Key? key, required this.img, required this.itemNo, required this.itemName, required this.itemDetails,required this.removeOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Material(
      child: Container(
        width: size.width * 0.47,


        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        decoration: BoxDecoration(
          color: kQuoteBackgroundColor,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 10),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  //goToScreen(context, ItemInfoScreen(item: item));
                },
                icon: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: atoNetworkImage(
                      img,
                      height: 100,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitHeight,
                    )),
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '$itemName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kLabelItemName_font,
                      textAlign: TextAlign.start,

                    ),
                  ),

                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Details : ${itemDetails}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kLabelItemName_font,
                      textAlign: TextAlign.start,

                    ),
                  ),

                ],
              ),
              Gap(10),
              RemoveBtn(buttonText: 'Remove', onTap: removeOnTap ,)

            ],
          ),
        ),
      ),
    );
  }
}