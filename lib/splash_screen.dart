import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:upgrader/upgrader.dart';
//import 'package:visions_academy/SubscriptionPage/updator.dart';
import 'BottomBar/bottom_bar_pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   
    navigateUser();
  }

  // On Android, setup the Appcast.
  // On iOS, the default behavior will be to use the App Store version of
  // the app, so update the Bundle Identifier in example/ios/Runner with a
  // valid identifier already in the App Store.

  navigateUser() {
    
      FirebaseAuth.instance.authStateChanges().listen((currentUser) {
        if (currentUser == null) {
          Timer(Duration(seconds: 6),
              () => Navigator.pushReplacementNamed(context, "/register"));
        } else {
          Timer(
            Duration(seconds: 6),
            () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BottomBar()),
                (Route<dynamic> route) => false),
          );
        }
      });
    
  }

  

  //Design Your splash screen
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: AssetImage('assets/splash_screen/a.gif'), //images
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Visions App",
                style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontSize: 30)),
            RaisedButton(
              elevation: 23,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                
                  FirebaseAuth.instance
                      .authStateChanges()
                      .listen((currentUser) async {
                    if (currentUser == null) {
                      Navigator.pushReplacementNamed(context, "/register");
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => BottomBar()),
                          (Route<dynamic> route) => false);
                    }
                  });
                
              },
              color: Colors.redAccent,
              child: Text("Knowledge is power, Know to grow",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
