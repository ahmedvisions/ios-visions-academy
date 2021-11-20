
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:visions_academy/ui/screens/home_screen/home_screen.dart';
import 'ui/screens/login_signup/login/login_screen.dart';
import 'ui/screens/login_signup/sign_up/signup_screen.dart';
import 'ui/screens/login_signup/splach_screen/splach_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// init your dependency injection here
  runApp(MyApp());
}

Future<void> secureScreen() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _platform = false;

  void deviceInfo() async {
    if (Platform.isAndroid) {
      _platform = true;
    } else if (Platform.isIOS) {
      _platform = true;
    } else {
      _platform = false;
    }
  }

  @override
  void initState() {
    deviceInfo();
    print("this is the _platform === $_platform");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor:  Colors.blue),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: _platform == true ? const SplachScreen() : Container(),
      // routes: {
      //   // Home.routeName: (context) =>  const Home(),
      //   // LoginScreen.routeName: (ctx) =>  const LoginScreen(),
      //   // SignupScreen.routeName: (ctx) => const SignupScreen(),
      //    'home': (ctx) => Home(),
      //   '/hh': (context) => const SplachScreen(),
      //   '/register': (context) => const SignupScreen(),
      //   '/log': (context) => const LoginScreen(),
      //
      //   // '/ChaptersOr': (context) => ChaptersOr(), // oragnai
      //   // '/ChapterOneOrganic': (context) => ChapterOneOrganic(),
      //   // '/News': (context) => News(),
      //   // '/Moodle': (context) => Moodle(),
      // },
    );
  }
}

