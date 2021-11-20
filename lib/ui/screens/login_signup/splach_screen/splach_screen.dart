import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visions_academy/components/component.dart';
import 'package:visions_academy/onboarder/onboarding_screen.dart';
import 'package:visions_academy/ui/screens/home_screen/home_screen.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/database.dart';
import 'on_boarding.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key key}) : super(key: key);

  @override
  _SplachScreenState createState() => _SplachScreenState();
}


class _SplachScreenState extends State<SplachScreen> {
  final DatabaseService _databaseService = new DatabaseService();
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  navigateUser() {
    FirebaseAuth.instance.authStateChanges().listen((currentUser) async {
      if (currentUser == null) {
        Timer(const Duration(seconds: 6),
                () =>navigateAndFinish(context,OnboardingScreen()));
      } else {
        String savedDeviceId = await _databaseService.getDevIdFromDatabase();
        String deviceId = await _databaseService.getId();
        if (deviceId == savedDeviceId)
          Timer(const Duration(seconds: 6),
                  () =>navigateAndFinish(context, const Home()));

        else {
          Timer(Duration(seconds: 6),
                  () => Navigator.pushReplacementNamed(context, "/log"));
        }
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Lottie.asset('assets/lottieJson/splach_screen.json',
            width: 150, height: 150, fit: BoxFit.cover),
      ),
    );
  }
}
