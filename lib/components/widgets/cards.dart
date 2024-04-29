import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/images.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/models/item.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/item_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/actions.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';


void openColorPicker({
  required BuildContext context,
  required Color selectedColor,
  required onChange,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      LocaleProvider loc = Provider.of(context);
      return AlertDialog(
        title: Text(loc.of(Tr.color)),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              onChange(color);
            },
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(loc.of(Tr.ok)),
          ),
        ],
      );
    },
  );
}
Widget atoShopItemCard(BuildContext context, ItemModel item, LocaleProvider loc) {
  String text = item.name +
      ((item is ClothModel) ? " ${loc.of(Tr.size)}:${item.size}" : "");

  return Card(
    color: cardBackgroundColor,
    shape: ShapeBorder.lerp(LinearBorder.none, LinearBorder.none, 0),
    child: Stack(children: [
      Container(
        padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
        alignment: Alignment.center,
        child: IconButton(
          onPressed: () {
            goToScreen(context, ItemInfoScreen(item: item));
          },
          icon: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: item.image.startsWith("assets")
                  ? Image.asset(
                item.image,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              )
                  : atoNetworkImage(
                item.image,
                fit: BoxFit.contain,
              )),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20, top: 4),
        child: Text(
          "#1234",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.bottomRight,
                  onPressed: () {
                    goToScreen(context, ItemInfoScreen(item: item));
                  },
                  icon: atoAssetOfIcon("add-to-cart.png", width: 16, height: 16))),
          Container(
            width: 80,
            alignment: Alignment.bottomCenter,
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )
    ]),
  );
}
