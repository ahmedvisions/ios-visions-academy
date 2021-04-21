import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:visions_academy/SubscriptionPage/SubscriptionPage.dart';
import 'package:visions_academy/biochemistry/chaptersbio.dart';
import 'package:visions_academy/data_for_log_register/auth.dart';

import '../constants.dart';

class CoursesPh extends StatefulWidget {
  @override
  _CoursesPhState createState() => _CoursesPhState();
}

PageController _pageController;

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
        var dueDate =
            value.data()["Course"][selectedCourse]["DueDate"].toDate();

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
          title: Text(
            "Pharmacy",
          ),
          elevation: 30,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: 2000,
          padding: EdgeInsets.all(30),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.orangeAccent,
                              ),
                              Text("Pharmacology II",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.blue,
                              ),
                              Text("Pharmaceutics II",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      child: InkWell(
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.yellow,
                              ),
                              Text("pharmacology 1",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      child: InkWell(
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.blue,
                              ),
                              Text("Pharmacology III",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.deepPurple,
                              ),
                              Text("Physical Pharmacy",
                                  style: new TextStyle(
                                      fontSize: 13, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.red,
                              ),
                              Text("General biology",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.pink,
                              ),
                              Text("physiology",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.deepOrange,
                              ),
                              Text("Pharmacotherapy I",
                                  style: new TextStyle(
                                      fontSize: 13, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.deepOrange,
                              ),
                              Text("Pharmacotherapy II",
                                  style: new TextStyle(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.deepOrange,
                              ),
                              Text("Pharmacotherapy III",
                                  style: new TextStyle(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius:
                          BorderRadius.all(Radius.circular(25.0))),
                      child: InkWell(
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.deepOrange,
                              ),
                              Text("Microbiology",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),



              ////////////////////////////////////////////
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 130,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius:
                          BorderRadius.all(Radius.circular(25.0))),
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
                              Icon(
                                Icons.book,
                                size: 70,
                                color: Colors.deepOrange,
                              ),
                              Text("Anatomy",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(right: 15.0),
              //       child: Container(
              //         height: 130,
              //         width: 120.0,
              //         decoration: BoxDecoration(
              //             color: Colors.teal,
              //             borderRadius:
              //             BorderRadius.all(Radius.circular(25.0))),
              //         child: InkWell(
              //           // onTap: () async {
              //           //   try {
              //           //     if (purchaserInfo.activeSubscriptions
              //           //         .contains('physiology') ||
              //           //         await checkmanual('physiology')) {
              //           //       Navigator.push(
              //           //           context,
              //           //           MaterialPageRoute(
              //           //               builder: (context) => ChaptersBio(
              //           //                   courseName: 'physiology')));
              //           //     } else {
              //           //       try {
              //           //         if (offerings
              //           //             .getOffering("physiology")
              //           //             .availablePackages
              //           //             .isNotEmpty) {
              //           //           package = offerings.current.threeMonth;
              //           //
              //           //           // Display packages for sale
              //           //         }
              //           //       } on PlatformException catch (e) {
              //           //         // optional error handling
              //           //         print(e.toString());
              //           //       }
              //           //       Navigator.push(
              //           //           context,
              //           //           MaterialPageRoute(
              //           //               builder: (context) => SubscriptionPage(
              //           //                 offerings: offerings,
              //           //                 purchaserInfo: purchaserInfo,
              //           //                 package: offerings
              //           //                     .getOffering("physiology")
              //           //                     .threeMonth,
              //           //                 email: userId.email,
              //           //               )));
              //           //       print(offerings);
              //           //     }
              //           //   } catch (e) {
              //           //     print("Problem is :   " + e.toString());
              //           //   }
              //           // },
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
              //             color: Colors.limeAccent,
              //             borderRadius:
              //             BorderRadius.all(Radius.circular(25.0))),
              //         child: InkWell(
              //           // onTap: () async {
              //           //   try {
              //           //     if (purchaserInfo.activeSubscriptions
              //           //         .contains('physiology') ||
              //           //         await checkmanual('physiology')) {
              //           //       Navigator.push(
              //           //           context,
              //           //           MaterialPageRoute(
              //           //               builder: (context) => ChaptersBio(
              //           //                   courseName: 'physiology')));
              //           //     } else {
              //           //       try {
              //           //         if (offerings
              //           //             .getOffering("physiology")
              //           //             .availablePackages
              //           //             .isNotEmpty) {
              //           //           package = offerings.current.threeMonth;
              //           //
              //           //           // Display packages for sale
              //           //         }
              //           //       } on PlatformException catch (e) {
              //           //         // optional error handling
              //           //         print(e.toString());
              //           //       }
              //           //       Navigator.push(
              //           //           context,
              //           //           MaterialPageRoute(
              //           //               builder: (context) => SubscriptionPage(
              //           //                 offerings: offerings,
              //           //                 purchaserInfo: purchaserInfo,
              //           //                 package: offerings
              //           //                     .getOffering("physiology")
              //           //                     .threeMonth,
              //           //                 email: userId.email,
              //           //               )));
              //           //       print(offerings);
              //           //     }
              //           //   } catch (e) {
              //           //     print("Problem is :   " + e.toString());
              //           //   }
              //           // },
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
            ],
          ),
        ),
      ),
    );
  }
}
