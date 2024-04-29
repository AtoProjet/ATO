import 'package:ato/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:ato/components/actions.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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


Stack LoadingStack({required Widget child, required bool isLoading}) {
  return Stack(children: [
    child,
  ]);
}
atoToastSuccess(BuildContext context,String text){
 return toastification.show(
    context: context,
    icon: const Icon(Icons.check_circle),
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    margin: const EdgeInsets.only(bottom: 8),
    autoCloseDuration: const Duration(seconds: 5),
    showProgressBar: false,
    description: Text(text, style: const TextStyle(color: Colors.black, fontSize: 13), textAlign: TextAlign.justify,),
    alignment: Alignment.topCenter,
   animationDuration: const Duration(milliseconds: 300),


  );
}


atoToastError(BuildContext context, String text){
  toastification.show(
    context: context,
    type: ToastificationType.error,
    icon: const Icon(Icons.error),
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
    margin: const EdgeInsets.only(bottom: 48),
    description: Text(text, style: const TextStyle(color: Colors.black, fontSize: 13), textAlign: TextAlign.justify,),
    alignment: Alignment.topCenter,
    showProgressBar: false,
    animationDuration: const Duration(milliseconds: 300),

  );
}