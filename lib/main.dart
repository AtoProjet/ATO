import 'sr_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'db/references.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Fire.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade100),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
