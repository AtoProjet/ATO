
import 'package:ato/models/user.dart';
import 'package:ato/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'db/references.dart';

Future<void> loadUser(String id) async {
  Fire ref= Fire.instance();
  await ref.userRef.doc(id).get().then((doc) {
    if (doc.exists) {
      var data = doc.data();
      UserModel.user = UserModel.fromJson(data as Map<String, dynamic>);
    }
  });
}

void checkUser() {
  Fire.auth = FirebaseAuth.instanceFor(app: Fire.app!);
  Fire.auth!.authStateChanges().listen((newUser) {}, onError: (e) {
    if (Fire.auth!.currentUser != null) {
      Fire.auth!.currentUser!.reload();
      loadUser(Fire.auth!.currentUser!.uid);
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Fire.app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  checkUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(title: "ATO"),
    );
  }
}
