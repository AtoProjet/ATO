import 'package:ato/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/actions.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

Directionality atoScaffold(
    {required BuildContext context,
    required Widget body,
    String title = "ATO",
    bool showAppBar = true,
    bool showAppBarBackground = true,
    bool showBackButton = true,
    BottomNavigationBar? bottomBar,
    FloatingActionButton? floatingActionButton,
    dynamic isLoading,
    Drawer? drawer}) {
  final provider = Provider.of<LocaleProvider>(context);
  return Directionality(
    textDirection: provider.isAr() ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      color: Colors.white,
      child: Stack(
        children: [
          if (showAppBarBackground)
            const SizedBox(
              width: double.infinity,
              height: 140.0,
              child: Image(
                image: AssetImage('assets/images/header.png'),
                fit: BoxFit.fill,
              ),
            ),
          if (!showAppBarBackground)
            Container(
              alignment: provider.isEn()
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              width: double.infinity,
              height: 100.0,
              child: Image.asset(
                'assets/images/ic_logo.jpg',
                height: 60,
                width: 120,
                fit: BoxFit.fill,
              ),
            ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, !showAppBar ? 0 : 36, 0, 0),
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.only(
                      top: !showAppBar ? 0 : (showAppBarBackground ? 48 : 36)),
                  child: body,
                ),
                floatingActionButton: floatingActionButton,
                bottomNavigationBar: bottomBar,
                backgroundColor: Colors.transparent,
                drawer: drawer,
                extendBody: true,
                resizeToAvoidBottomInset: true,
                appBar: showAppBar
                    ? _atoAppBar(context,
                        title: title,
                        showBackIcon: showBackButton,
                        textColor: showAppBarBackground
                            ? Colors.white
                            : Colors.grey.shade600)
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
    ),
  );
}

AppBar _atoAppBar(BuildContext context,
    {String title = "ATO",
    bool showBackIcon = true,
    Color textColor = Colors.white}) {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        if (showBackIcon) {
          goBack(context);
        }
      },
      child: showBackIcon
          ? Icon(
              Icons.arrow_back_ios,
              color: textColor,
            )
          : null,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: textColor,
      ),
    ),
    toolbarHeight: 30,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
  );
}

Image assetIcon({
  required String name,
  double width = 24,
  double height = 24,
}) {
  return Image.asset(
    "assets/icons/$name",
    width: width,
    height: height,
  );
}

DecorationImage assetCategory({
  required String name,
}) {
  return DecorationImage(
    image: AssetImage("assets/categories/$name"),
    fit: BoxFit.cover,
  );
}

MaterialButton atoDarkMaterialButton({
  required onPressed,
  required String text,
  double fontSize = 16,
  Color? color,
  String? icon,
  bool enabled = true,
  bool changeIconColor = true,
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
      if (icon != null) Image.asset(icon,
        alignment: Alignment.centerLeft,
        color: changeIconColor?Colors.white.withOpacity(0.8): null, height: fontSize*1.5,),
      Padding(
        padding: icon!= null? const EdgeInsets.only(left: 16): EdgeInsets.zero,
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, ),
        ),
      ),
    ]),
  );
}

MaterialButton atoLightMaterialButton({
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

FloatingActionButton atoFloatingActionButtonAdd({required onPressed}) {
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

Center atoProfileImage({String? url, double radius = 48}) {
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: url != null
          ? Image.network(
              url,
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
            )
          : Image.asset(
              "assets/images/ic_user_female.jpg",
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
            ),
    ),
  );
}

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
