import 'package:ato/providers/locale_provider.dart';
import 'package:ato/components/widgets.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/locale.dart';
import 'package:ato/models/user.dart';
import 'package:ato/sr_screens/login_screen.dart';
import 'package:ato/components/actions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String title = "Profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user = UserModel.user!;
  final double _fontSize= 18;
  final double _iconSize= 32;

  @override
  Widget build(BuildContext context) {
    final LocaleProvider loc = Provider.of(context);
    return atoScaffold(
      context: context,
      showAppBarBackground: false,
      title: ProfileScreen.title,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          children: [
            atoProfileImage(url: user.image),
            Center(
                child: Text(
              user.name,
              style: headerStyle(),
            )),
            Center(child: Text(user.email)),
            Container(
              margin: const EdgeInsets.fromLTRB(36,20, 36, 20 ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(UserModel.user!.role== "Admin")
                      TextButton(
                        onPressed: () {},
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 16),
                            Icon(
                              Icons.notifications_outlined,
                              color: Colors.black87,
                              size: _iconSize,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              loc.of(Tr.notifications),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      if(UserModel.user!.role== "Admin")
                      const Divider(),
                      if(UserModel.user!.role== "Donor" || UserModel.user!.role== "Admin")
                      TextButton(
                        onPressed: () {},
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 16),
                            Icon(
                              Icons.mark_unread_chat_alt_outlined,
                              color: Colors.black87,
                              size: _iconSize,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              loc.of(Tr.orders),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      if(UserModel.user!.role== "Donor" || UserModel.user!.role== "Admin")
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          changeLanguage(loc, loc.of(Tr.switchLang));
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 16),
                            Icon(
                              Icons.language,
                              color: Colors.black87,
                              size: _iconSize,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              loc.of(Tr.switchLang),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          logout();
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 16),
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.black87,
                              size: _iconSize,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              loc.of(Tr.logout),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: _fontSize, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  logout(){
    Fire.auth.signOut().then((value){
      setState(() {
        UserModel.user= null;
        goToScreenAndClearHistory(context, const LoginScreen());
      });

    });
  }

  notifications(){

  }

  changeLanguage(LocaleProvider loc, String lang) async{
    Locale target;
    if(lang== "English") {
      target = loc.en();
    } else{
        target= loc.ar();
    }
    await Fire.localeRef.doc(UserModel.user!.id).set(LocaleModel(name: target.languageCode).toMap());
    loc.setLocale(target);
  }
  showOrders(){

  }

}
