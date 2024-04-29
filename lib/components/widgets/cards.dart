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

Widget atoShopItemCard(
    BuildContext context, ItemModel item, LocaleProvider loc) {
  String text = item.name;
  return Card(
    color: cardBackgroundColor,
    shape: ShapeBorder.lerp(LinearBorder.none, LinearBorder.none, 0),
    child: Stack(children: [
      Container(
        height: 120,
        width: 220,
        padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
        child: IconButton(
          onPressed: () {
            goToScreen(context, ItemInfoScreen(item: item));
          },
          icon: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: atoNetworkImage(
                item.image,
                height: 120,
                fit: BoxFit.contain,
              )),
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
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
                  icon: atoAssetOfIcon("add-to-cart.png",
                      width: 16, height: 16))),
          Container(
            width: 100,
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
