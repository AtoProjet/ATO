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

