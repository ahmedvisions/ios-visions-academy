import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:visions_academy/ui/screens/course/biochemistry/chaptersbio.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/auth.dart';
import 'package:visions_academy/ui/screens/moodlescreen/subscribtionpage/subscription_page.dart';

import '../../../../constants.dart';


//  finished


class CoursesPh extends StatefulWidget {
  @override
  _CoursesPhState createState() => _CoursesPhState();
}



class _CoursesPhState extends State<CoursesPh> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              "Pharmacy",
            ),
            elevation: 0,
            backgroundColor: Colors.lightBlue
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: 2000,
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
                            .contains('pharmacology_20') ||
                            await checkmanual('pharmacology_20')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'pharmacology_20')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("pharmacology_20")
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
                                        .getOffering("pharmacology_20")
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
                    child:Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Image.asset(
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),

                          const Text("Pharmacology II",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black)),
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
                    onTap: () async {
                      try {


                        if (purchaserInfo.activeSubscriptions
                            .contains('pharmaceutics_2') ||
                            await checkmanual('pharmaceutics_2')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'pharmaceutics_2')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("pharmaceutics_2")
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
                                        .getOffering("pharmaceutics_2")
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
                    child: Center(
                      child:  Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset(
                                  'assets/images/medical.ico'),
                              iconSize: 70,
                            ),

                            const Text("Pharmaceutics II",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black)),
                          ],
                        ),
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
                            .contains('pharmacology_01') ||
                            await checkmanual('pharmacology_01')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'pharmacology_01')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("pharmacology_01")
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
                                        .getOffering("pharmacology_01")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),

                          const Text("pharmacology 1",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black)),
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
                            .contains('pharmacology_03') ||
                            await checkmanual('pharmacology_03')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'pharmacology_03')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("pharmacology_03")
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
                                        .getOffering("pharmacology_03")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),

                          const Text("Pharmacology III",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black)),
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
                    onTap: () async {
                      try {

                        if (purchaserInfo.activeSubscriptions
                            .contains('physical') ||
                            await checkmanual('physical')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'physical')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("physical")
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
                                        .getOffering("physical")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          const Text("Physical Pharmacy",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black)),
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
                    onTap: () async {
                      try {

                        if (purchaserInfo.activeSubscriptions
                            .contains('biology') ||
                            await checkmanual('biology')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'biology')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("biology")
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
                                        .getOffering("biology")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          const Text("General biology",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black)),
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
                    onTap: () async {
                      try {

                        if (purchaserInfo.activeSubscriptions
                            .contains('physiology') ||
                            await checkmanual('physiology')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'physiology')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("physiology")
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
                                        .getOffering("physiology")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          const Text("physiology",
                              style:  TextStyle(
                                  fontSize: 14, color: Colors.black)),
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
                    onTap: () async {
                      try {


                        if (purchaserInfo.activeSubscriptions
                            .contains('pharmacotherapy_1') ||
                            await checkmanual('pharmacotherapy_1')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'pharmacotherapy_1')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("pharmacotherapy_1")
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
                                        .getOffering("pharmacotherapy_1")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          Text("Pharmacotherapy I",
                              style: new TextStyle(
                                  fontSize: 13, color: Colors.black)),
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
                    onTap: () async {
                      try {

                        if (purchaserInfo.activeSubscriptions
                            .contains('pharmacotherapy_2') ||
                            await checkmanual('pharmacotherapy_2')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'pharmacotherapy_2')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("pharmacotherapy_2")
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
                                        .getOffering("pharmacotherapy_2")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          Text("Pharmacotherapy II",
                              style: new TextStyle(
                                  fontSize: 12, color: Colors.black)),
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
                    onTap: () async {
                      try {
                        if (purchaserInfo.activeSubscriptions
                            .contains('pharmacotherapy_3') ||
                            await checkmanual('pharmacotherapy_3')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'pharmacotherapy_3')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("pharmacotherapy_3")
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
                                        .getOffering("pharmacotherapy_3")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          Text("Pharmacotherapy III",
                              style: new TextStyle(
                                  fontSize: 12, color: Colors.black)),
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
                  child:InkWell(
                    onTap: () async {

                      try {
                        if (purchaserInfo.activeSubscriptions
                            .contains('microbiology') ||
                            await checkmanual('microbiology')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'microbiology')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("microbiology")
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
                                        .getOffering("microbiology")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          Text("Microbiology",
                              style: new TextStyle(
                                  fontSize: 14, color: Colors.black)),
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
                    onTap: () async {
                      try {
                        if (purchaserInfo.activeSubscriptions
                            .contains('anatomy') ||
                            await checkmanual('anatomy')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChaptersBio(
                                      courseName: 'anatomy')));
                        } else {
                          try {
                            if (offerings
                                .getOffering("anatomy")
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
                                        .getOffering("anatomy")
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
                                'assets/images/medical.ico'),
                            iconSize: 70,
                          ),
                          Text("Anatomy",
                              style: new TextStyle(
                                  fontSize: 14, color: Colors.black)),
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

            ],
          ),
        ),
      ),
    );
  }
}
