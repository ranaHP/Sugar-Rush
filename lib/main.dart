import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/screen/splash_screen.dart';

import 'screen/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColors,
      ),
      home: SplashScreen(),
    );
  }
}
