import 'package:ato/components/widgets/cards.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/actions.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

MaterialButton atoDarkMaterialButton({
  required onPressed,
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
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
                text,
                style: TextStyle(fontSize: fontSize, ),
              ),
    ),
  );
}

MaterialButton atoIconTextMaterialButton({
  required onPressed,
  required String text,
  required String icon,
  double fontSize = 16,
  Color? color,
  bool enabled = true,
  bool changeIconColor = true,
  double iconMargin= 8,
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
    padding: const EdgeInsets.all(4),
    child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Image.asset(icon,
            alignment: Alignment.centerLeft,
            color: changeIconColor?Colors.white.withOpacity(0.8): null, height: fontSize*1.5,),
          Padding(
            padding: EdgeInsets.only(left: iconMargin , right: iconMargin),
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ]),
  );
}

// MaterialButton atoLightMaterialButton({
//   required onPressed,
//   required String text,
//   double fontSize = 16,
//   Color? color,
//   Color? textColor,
//   enabled = false,
// }) {
//   textColor ??= const Color.fromRGBO(15, 61, 123, 1);
//   color ??= Colors.grey.shade300;
//   return MaterialButton(
//     onPressed: enabled ? onPressed : null,
//     color: color,
//     textColor: textColor,
//     elevation: 5,
//     disabledColor: Colors.grey,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     padding: const EdgeInsets.all(12),
//     child: Text(
//       text,
//       style: TextStyle(fontSize: fontSize),
//     ),
//   );
// }

// FloatingActionButton atoFloatingActionButtonAdd({required onPressed}) {
//   return FloatingActionButton(
//     onPressed: onPressed,
//     tooltip: 'Add',
//     backgroundColor: const Color.fromRGBO(15, 61, 123, 0.5),
//     child: const Icon(Icons.add, color: Colors.white),
//   );
// }


RadioMenuButton atoRadioButton({
  required groupValue,
  required onChange,
  required String text,
  required String val,
}) {
  return RadioMenuButton(
    value: val,
    style: ButtonStyle(iconSize: MaterialStateProperty.all(10)),
    groupValue: groupValue,
    onChanged: (value) {
      onChange(value);
    },
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ),
  );
}

CheckboxMenuButton atoCheckBox({
  required BuildContext context,
  required text,
  required onChange,
  required index,
  bool val = false,
}) {
  return CheckboxMenuButton(
    value: val,
    onChanged: (value) {
      onChange(index, value);
    },
    child: Text(
      text,
    ),
  );
}

Wrap atoColorPickerButton({
  required BuildContext context,
  required Color selectedColor,
  required onChange,
}) {
  return Wrap(
    direction: Axis.horizontal,
    children: [
      TextButton(
        onPressed: () => openColorPicker(
            context: context, selectedColor: selectedColor, onChange: onChange),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
          color: Colors.grey.shade500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 20,
                height: 20,
                color: selectedColor,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

