import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:visions_academy/Home_and_Screen/news.dart';
import 'package:visions_academy/register_login/login.dart';
import 'package:visions_academy/splash_screen.dart';
import 'BottomBar/bottom_bar_pages.dart';
import 'moodle/moodle1.dart';
import 'organic1/ChapterOneOrganicVideo.dart';
import 'organic1/chaptersor.dart';
import 'register_login/registration.dart';
import 'package:get/get.dart';

//now see if change any thing , and save, android studio will change that file
// color, let see main.dart file's color, when i will save
//main.dart file color is changed when i saved button.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // await secureScreen();
  runApp(MyApp());
}

Future<void> secureScreen() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
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
////////////////////////////////////check update

    return GetMaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: _platform == true ? SplashScreen() : Container(),
      routes: {
        '/Botton': (context) => BottomBar(),
        '/register': (context) => SignUp(),
        '/log': (context) => Login(),
        '/hh': (context) => SplashScreen(),
        '/ChaptersOr': (context) => ChaptersOr(), // oragnai
        '/ChapterOneOrganic': (context) => ChapterOneOrganic(),
        '/News': (context) => News(),
        '/Moodle': (context) => Moodle(),
      },
    );
  }
}
