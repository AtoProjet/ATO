import 'package:ato/providers/cart_provider.dart';
import 'package:ato/providers/item_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/models/user.dart';
import 'package:ato/sr_screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'db/references.dart';


Future<UserModel?> checkUser() async {
  try {
    if (Fire.auth.currentUser != null) {
      await Fire.auth.currentUser!.reload();
      if (Fire.auth.currentUser != null) {
        var doc = await Fire.userRef.doc(Fire.auth.currentUser!.uid).get();
        if (doc.exists) {
          var data = doc.data();
          return UserModel.fromJson(data as Map<String, dynamic>);
        }
      }
    }
  } catch (_) {
    return null;
  }
  return null;
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Fire.init();
  UserModel.user = await checkUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<ItemProvider>(create: (_) => ItemProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: provider.locales,
      locale: provider.locale,
      onGenerateTitle: (context) => provider.of(Tr.appName),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade100),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

