import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:new_version/new_version.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_flutter/package_wrapper.dart';
import 'package:visions_academy/components/component.dart';
import 'package:visions_academy/ui/screens/course/a_pharmcy/coursesph.dart';
import 'package:visions_academy/ui/screens/course/a_sciences/courses_sciences.dart';
import 'package:visions_academy/ui/screens/course/an_engineering/courses_engineer.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/auth.dart';
import 'package:visions_academy/ui/screens/moodlescreen/module/module_screen.dart';
import 'package:visions_academy/ui/screens/moodlescreen/subscribtionpage/subscription_page.dart';
 import 'package:visions_academy/ui/screens/notfaction_screen/notfaction.dart';
import '../../../../constants.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({Key key, @required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User userId;
  var purchaserInfo;
  Package package;
  Offerings offerings;
  String isrequestAlready;

  AuthService authService = AuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // @override
  // void initState() {
  //   super.initState();
  //   _checkVersion();
  // }
  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //     androidId: "com.visionsacademy.visions_academy",    // id package name Android
  //     // iOSId: ""
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(
  //     context: context,
  //     versionStatus: status,
  //     dialogTitle: "UPDATE!!!",
  //     dismissButtonText: "Skip",
  //     dialogText: "Please update the app from " + "${status.localVersion}" + " to " + "${status.storeVersion}",
  //     dismissAction: () {
  //       SystemNavigator.pop();
  //     },
  //     updateButtonText: "Lets update",
  //   );
  //
  //   print("DEVICE : " + status.localVersion);
  //   print("STORE : " + status.storeVersion);
  // }
  Future<bool> checkmanual(String selectedCourse) async {
    bool isavail;
    try {
      await firestore.collection("ManualPayment").doc(u_id).get().then(
              (value) =>
          isavail = value.data()["Course"][selectedCourse]["isPurchased"]);
      print(isavail.toString());
    } catch (err) {
      print(err);
      isavail = false;
    }
    return isavail;
  }

  Future<void> initPlatformState() async {
    try {
      await Purchases.setDebugLogsEnabled(true);
      userId = authService.getCurrentUser();

      u_id = userId.uid;
      await Purchases.setup(publicKeyRevenuCat, appUserId: userId.uid);
      await Purchases.addAttributionData(
          {}, PurchasesAttributionNetwork.facebook);
      purchaserInfo = await Purchases.identify(u_id);
      offerings = await Purchases.getOfferings();
    } catch (e) {
      print("Error: " + e.toString());
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery
        .of(context)
        .size
        .height;
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, right: 15.0, left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconBadge(
                      itemCount: 2,
                      badgeColor: Colors.yellow,
                      icon: const Icon(Icons.notifications_none),
                      itemColor: Colors.grey,
                      onTap: () {

                        navigateTo(context,NotfactionScreen());
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              // padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap:() {
                  navigateTo(context, Moodle());
                },
                child: Container(
                  width: width,
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blueAccent,
                      Colors.lightBlue,
                      Colors.lightBlueAccent,
                    ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(80),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 3),
                          blurRadius: 5,
                          color: Colors.white),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Start Learning",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Module",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        Row(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: Container()),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.lightBlueAccent,
                                          blurRadius: 10,
                                          offset: Offset(4, 8))
                                    ]
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(

                                      icon: const Icon(Icons.school,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    onPressed: () async {
                                      try {
                                        if (purchaserInfo
                                            .activeSubscriptions
                                            .contains('moodle') ||
                                            await checkmanual(
                                                'moodle')) // this check is for organic_1 .
                                            {

                                          navigateTo(context,Moodle());
                                        } else {
                                          try {
                                            if (offerings
                                                .getOffering("moodle")
                                                .availablePackages
                                                .isNotEmpty) {
                                              package = offerings
                                                  .current.threeMonth;
                                              // Display packages for sale
                                            }
                                          } on PlatformException catch (e) {
                                            // optional error handling
                                            print(e.toString());
                                          }
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubscriptionPage(
                                                        offerings:
                                                        offerings,
                                                        purchaserInfo:
                                                        purchaserInfo,
                                                        package: offerings
                                                            .getOffering(
                                                            "moodle")
                                                            .threeMonth,
                                                        email: userId.email,
                                                      )));
                                          print(offerings);
                                        }
                                      } catch (e) {
                                        print("Problem is :   " +
                                            e.toString());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: Text(
                    "All Course",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: kTextColor),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 35, top: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150.0,
                    width: double.infinity,
                    child: ListView(
                        addAutomaticKeepAlives: true,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 120.0,
                              child: InkWell(
                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CoursesPh()

                                      ));

                                },
                                splashColor: Colors.black,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Image.asset(
                                            'assets/images/heartbeat.ico'),
                                        iconSize: 70,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CoursesPh()

                                              ));
                                        },
                                      ),

                                      const Text("Pharmacy and",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black)),
                                      const Text("Nursing",
                                          style:
                                          TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                  left: 5, top: 10, right: 5, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 120.0,
                              child: InkWell(
                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CoursesEngineer()));

                                },
                                splashColor: Colors.black,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Image.asset(
                                            'assets/images/enginerr.ico'),
                                        iconSize: 70,
                                        onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CoursesEngineer()));
                                      },
                                      ),

                                      const Text("Engineering and",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.lightBlue)),
                                      const Text(" architecture",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.lightBlue)),
                                    ],
                                  ),
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                  left: 5, top: 10, right: 5, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 120.0,
                              child: InkWell(
                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CoursesSciences()));

                                },
                                splashColor: Colors.black,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Image.asset(
                                            'assets/images/science.ico'),
                                        iconSize: 70, onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CoursesSciences()));
                                      },
                                      ),
                                      const Text(" Sciences and",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black)),
                                      const Text(" Arts ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                  left: 5, top: 10, right: 5, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ]),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }


}


