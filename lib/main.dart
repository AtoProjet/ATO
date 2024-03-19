
import 'package:ato/models/user.dart';
import 'package:ato/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'db/firebase_options.dart';
import 'db/references.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;
late UserModel? user;

Future<void> loadUser(String id) async {
  Refs ref= Refs.instance();
  await ref.userRef.doc(id).get().then((doc) {
    if (doc.exists) {
      var data = doc.data();
      user = UserModel.fromJson(data as Map<String, dynamic>);
    }
  });
}

void checkUser() {
  auth = FirebaseAuth.instanceFor(app: app);
  auth.authStateChanges().listen((newUser) {}, onError: (e) {
    if (auth.currentUser != null) {
      auth.currentUser!.reload();
      loadUser(auth.currentUser!.uid);
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app= await Firebase.initializeApp(
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
