import 'package:ato/widgets/admin_widgets/common_widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/actions.dart';
import '../components/app_layout.dart';
import '../components/constants.dart';
import '../components/widgets.dart';
import '../db/references.dart';
import '../models/locale.dart';
import '../models/user.dart';
import '../providers/locale_provider.dart';
import '../sr_screens/login_screen.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  UserModel user = UserModel.user!;
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    const kIconColor = Colors.black87;
    final size = AppLayout.getSize(context);

    return ListView(
      children: [
        // logo
        Topbar(isBack: false),
        // Container(
        //
        //   alignment: provider.isEn()
        //       ? Alignment.bottomRight
        //       : Alignment.bottomLeft,
        //   width: double.infinity,
        //   height: 100.0,
        //   child: const SizedBox(
        //     height: 80,
        //     child:  Image(
        //       image: AssetImage('assets/images/ic_logo.jpg'),
        //       fit: BoxFit.contain,
        //     ),
        //   ),
        // ),
        Gap(35),
        // profile icon
        atoProfileImage(url: user.image),
        Gap(10),
        //user name
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.name,
              style: kLabelProfileName_font,)
          ],
        ),
        Gap(3),
        // user email
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email,
              style: kLabelProfileEmail_font,)
          ],
        ),
        Gap(25),
        Container(
          width: size.width * .2,

          margin: const EdgeInsets.symmetric(horizontal: 55, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 15, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.notifications_none, size: 28,color: kIconColor,),
                        Gap(15),
                        Text(loc.of(Tr.notifications), style: kLabelTextProfileList_font,)

                      ],
                    ),
                  ),

                  Divider(thickness: 1.5,color: Colors.grey[400],),
                  TextButton(
                    onPressed: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.grid_view, size: 28,color: kIconColor),
                        Gap(15),
                        Text(loc.of(Tr.orders), style: kLabelTextProfileList_font,)

                      ],
                    ),
                  ),
                  Divider(thickness: 1.5,color: Colors.grey[400],),
                  TextButton(
                    onPressed: (){
                      changeLanguage(loc, loc.of(Tr.switchLang));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.language, size: 28,color: kIconColor),
                        Gap(15),
                        Text(loc.of(Tr.switchLang), style: kLabelTextProfileList_font,)

                      ],
                    ),
                  ),

                  Divider(thickness: 1.5,color: Colors.grey[400],),

                  TextButton(
                    onPressed: (){
                      logout();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 28,color: kIconColor),
                        Gap(15),
                        Text(loc.of(Tr.logout), style: kLabelTextProfileList_font,)

                      ],
                    ),
                  ),

                ],

              )
          ),
        ),




      ],
    );


  }
  changeLanguage(LocaleProvider loc, String lang) async{
    Locale target;
    if(lang== "English") {
      target = loc.en();
    } else{
      target= loc.ar();
    }
    await Fire.localeRef.doc(user.id).set(LocaleModel(name: target.languageCode).toMap());
    loc.setLocale(target);
  }
  logout(){
    Fire.auth.signOut().then((value){
      setState(() {
        UserModel.user= null;
        goToScreenAndClearHistory(context, const LoginScreen());
      });

    });
  }
}
