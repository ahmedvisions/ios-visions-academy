import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:visions_academy/ui/screens/course/biochemistry/chaptersbio.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/auth.dart';
 import 'package:visions_academy/ui/screens/moodlescreen/subscribtionpage/subscription_page.dart';

import '../../../../constants.dart';


// finish

class CoursesEngineer extends StatefulWidget {
  @override
  _CoursesEngineerState createState() => _CoursesEngineerState();
}

class _CoursesEngineerState extends State<CoursesEngineer> {
  User userId;
  var purchaserInfo;
  Package package;
  Offerings offerings;
  String isrequestAlready;

  AuthService authService = AuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> checkmanual(String selectedCourse) async {
    bool isavail;
    try {
      await firestore
          .collection("ManualPayment")
          .doc(u_id)
          .get()
          .then((value) async {
        isavail = value.data()["Course"][selectedCourse]["isPurchased"];
        var dueDate = value.data()["Course"][selectedCourse]["DueDate"];

        if (dueDate.isAfter(DateTime.now())) {
          print("Date is not passed");
        } else {
          print("Date is passed");
          var tempRefrence = firestore.collection("ManualPayment").doc(u_id);
          tempRefrence.set({
            'Course': {
              selectedCourse: {
                "isPurchased": false,
              }
            }
          }, SetOptions(merge: true));
        }
        print(dueDate.toString());
      });
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
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Engineering",
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 120.0,
                child: InkWell(
                  onTap: () async {
                    try {
                      if (purchaserInfo.activeSubscriptions
                          .contains('statics') ||
                          await checkmanual('statics')) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChaptersBio(courseName: 'statics')));
                      } else {
                        try {
                          if (offerings
                              .getOffering("statics")
                              .availablePackages
                              .isNotEmpty) {
                            package = offerings.current.threeMonth;

                            // Display packages for sale
                          }
                        } on PlatformException catch (e) {
                          // optional error handling
                          print(e.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriptionPage(
                                  offerings: offerings,
                                  purchaserInfo: purchaserInfo,
                                  package: offerings
                                      .getOffering("statics")
                                      .threeMonth,
                                  email: userId.email,
                                )));
                        print(offerings);
                      }
                    } catch (e) {
                      print("Problem is :   " + e.toString());
                    }
                  },
                  splashColor: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                              'assets/images/enginerr1.ico'),
                          iconSize: 70,
                        ),

                        const Text("Statics",
                            style: TextStyle(
                                fontSize: 13,
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
                child:  InkWell(
                  onTap: () async {
                    try {
                      if (purchaserInfo.activeSubscriptions
                          .contains('structural_1') ||
                          await checkmanual('structural_1')) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChaptersBio(
                                    courseName: 'structural_1')));
                      } else {
                        try {
                          if (offerings
                              .getOffering("structural_1")
                              .availablePackages
                              .isNotEmpty) {
                            package = offerings.current.threeMonth;

                            // Display packages for sale
                          }
                        } on PlatformException catch (e) {
                          // optional error handling
                          print(e.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriptionPage(
                                  offerings: offerings,
                                  purchaserInfo: purchaserInfo,
                                  package: offerings
                                      .getOffering("structural_1")
                                      .threeMonth,
                                  email: userId.email,
                                )));
                        print(offerings);
                      }
                    } catch (e) {
                      print("Problem is :   " + e.toString());
                    }
                  },
                  splashColor: Colors.orangeAccent,
                  child:Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                              'assets/images/enginerr1.ico'),
                          iconSize: 70,
                        ),

                        const Text("Structural Analysis I",
                            style: TextStyle(
                                fontSize: 13,
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
                child:  InkWell(
                  onTap: () async {
                    try {
                      if (purchaserInfo.activeSubscriptions
                          .contains('design_2') ||
                          await checkmanual('design_2')) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChaptersBio(courseName: 'design_2')));
                      } else {
                        try {
                          if (offerings
                              .getOffering("design_2")
                              .availablePackages
                              .isNotEmpty) {
                            package = offerings.current.threeMonth;

                            // Display packages for sale
                          }
                        } on PlatformException catch (e) {
                          // optional error handling
                          print(e.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriptionPage(
                                  offerings: offerings,
                                  purchaserInfo: purchaserInfo,
                                  package: offerings
                                      .getOffering("design_2")
                                      .threeMonth,
                                  email: userId.email,
                                )));
                        print(offerings);
                      }
                    } catch (e) {
                      print("Problem is :   " + e.toString());
                    }
                  },
                  splashColor: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                              'assets/images/enginerr1.ico'),
                          iconSize: 70,
                        ),
                        const Text("Structural Design II",
                            style: TextStyle(
                            fontSize: 13,
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
                child:  InkWell(
                  onTap: () async {
                    try {
                      if (purchaserInfo.activeSubscriptions
                          .contains('geotechnical_1') ||
                          await checkmanual('geotechnical_1')) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChaptersBio(
                                    courseName: 'geotechnical_1')));
                      } else {
                        try {
                          if (offerings
                              .getOffering("geotechnical_1")
                              .availablePackages
                              .isNotEmpty) {
                            package = offerings.current.threeMonth;

                            // Display packages for sale
                          }
                        } on PlatformException catch (e) {
                          // optional error handling
                          print(e.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriptionPage(
                                  offerings: offerings,
                                  purchaserInfo: purchaserInfo,
                                  package: offerings
                                      .getOffering("geotechnical_1")
                                      .threeMonth,
                                  email: userId.email,
                                )));
                        print(offerings);
                      }
                    } catch (e) {
                      print("Problem is :   " + e.toString());
                    }
                  },
                  splashColor: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                              'assets/images/enginerr1.ico'),
                          iconSize: 70,
                        ),
                        const Text("Geotechnical engineering I",
                            style: TextStyle(
                                fontSize: 12,
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
                child:  InkWell(
                  onTap: () async {
                    try {
                      if (purchaserInfo.activeSubscriptions
                          .contains('statistics') ||
                          await checkmanual('statistics')) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChaptersBio(courseName: 'statistics')));
                      } else {
                        try {
                          if (offerings
                              .getOffering("statistics")
                              .availablePackages
                              .isNotEmpty) {
                            package = offerings.current.threeMonth;

                            // Display packages for sale
                          }
                        } on PlatformException catch (e) {
                          // optional error handling
                          print(e.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriptionPage(
                                  offerings: offerings,
                                  purchaserInfo: purchaserInfo,
                                  package: offerings
                                      .getOffering("statistics")
                                      .threeMonth,
                                  email: userId.email,
                                )));
                        print(offerings);
                      }
                    } catch (e) {
                      print("Problem is :   " + e.toString());
                    }
                  },
                  splashColor: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                              'assets/images/enginerr1.ico'),
                          iconSize: 70,
                        ),
                        const Text("Statistics For Engineering",
                            style: TextStyle(
                                fontSize: 12,
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
                child:   InkWell(
                  onTap: () async {
                    try {
                      if (purchaserInfo.activeSubscriptions
                          .contains('civil_materials') ||
                          await checkmanual('civil_materials')) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChaptersBio(
                                    courseName: 'civil_materials')));
                      } else {
                        try {
                          if (offerings
                              .getOffering("civil_materials")
                              .availablePackages
                              .isNotEmpty) {
                            package = offerings.current.threeMonth;

                            // Display packages for sale
                          }
                        } on PlatformException catch (e) {
                          // optional error handling
                          print(e.toString());
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscriptionPage(
                                  offerings: offerings,
                                  purchaserInfo: purchaserInfo,
                                  package: offerings
                                      .getOffering("civil_materials")
                                      .threeMonth,
                                  email: userId.email,
                                )));
                        print(offerings);
                      }
                    } catch (e) {
                      print("Problem is :   " + e.toString());
                    }
                  },
                  splashColor: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        IconButton(
                          icon: Image.asset(
                              'assets/images/enginerr1.ico'),
                          iconSize: 70,
                        ),
                        const Text("Civil Engineering Materials",
                            style: TextStyle(
                                fontSize: 12,
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




            // Column(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(right: 15.0),
            //       child: Container(
            //         height: 130,
            //         width: 120.0,
            //         decoration: BoxDecoration(
            //             color: Colors.orange,
            //             borderRadius: BorderRadius.all(Radius.circular(25.0))),
            //         child: InkWell(
            //           onTap: () {
            //             //          Navigator.pushNamed(context, "/10");
            //           },
            //           splashColor: Colors.black,
            //           child: Center(
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: <Widget>[
            //                 Icon(
            //                   Icons.book,
            //                   size: 70,
            //                   color: Colors.pink,
            //                 ),
            //                 Text("Soon...",
            //                     style: new TextStyle(
            //                         fontSize: 12, color: Colors.black)),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(right: 15.0),
            //       child: Container(
            //         height: 130,
            //         width: 120.0,
            //         decoration: BoxDecoration(
            //             color: Colors.pink,
            //             borderRadius: BorderRadius.all(Radius.circular(25.0))),
            //         child: InkWell(
            //           onTap: () {
            //             //      Navigator.pushNamed(context, "/Chapters");
            //           },
            //           splashColor: Colors.black,
            //           child: Center(
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: <Widget>[
            //                 Icon(
            //                   Icons.book,
            //                   size: 70,
            //                   color: Colors.deepOrange,
            //                 ),
            //                 Text("Soon...",
            //                     style: new TextStyle(
            //                         fontSize: 14, color: Colors.black)),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(right: 15.0),
            //       child: Container(
            //         height: 130,
            //         width: 120.0,
            //         decoration: BoxDecoration(
            //             color: Colors.lime,
            //             borderRadius: BorderRadius.all(Radius.circular(25.0))),
            //         child: InkWell(
            //           onTap: () {
            //             //      Navigator.pushNamed(context, "/Chapters");
            //           },
            //           splashColor: Colors.black,
            //           child: Center(
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: <Widget>[
            //                 Icon(
            //                   Icons.book,
            //                   size: 70,
            //                   color: Colors.deepOrange,
            //                 ),
            //                 Text("Soon...",
            //                     style: new TextStyle(
            //                         fontSize: 14, color: Colors.black)),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Column(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(right: 15.0),
            //       child: Container(
            //         height: 130,
            //         width: 120.0,
            //         decoration: BoxDecoration(
            //             color: Colors.tealAccent,
            //             borderRadius: BorderRadius.all(Radius.circular(25.0))),
            //         child: InkWell(
            //           onTap: () {
            //             //     Navigator.pushNamed(context, "/Chapters");
            //           },
            //           splashColor: Colors.black,
            //           child: Center(
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: <Widget>[
            //                 Icon(
            //                   Icons.book,
            //                   size: 70,
            //                   color: Colors.deepOrange,
            //                 ),
            //                 Text("Soon...",
            //                     style: new TextStyle(
            //                         fontSize: 14, color: Colors.black)),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
