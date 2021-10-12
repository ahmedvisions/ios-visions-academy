import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:visions_academy/SubscriptionPage/SubscriptionPage.dart';
import 'package:visions_academy/biochemistry/chaptersbio.dart';
import 'package:visions_academy/data_for_log_register/auth.dart';

import '../constants.dart';

class CoursesSciences extends StatefulWidget {
  @override
  _CoursesSciencesState createState() => _CoursesSciencesState();
}

// PageController _pageController;

class _CoursesSciencesState extends State<CoursesSciences> {
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

        // if (dueDate.isAfter(DateTime.now().add(Duration(days: 1)))) {
        //   print("Date is not passed");
        // } else {
        //   print("Date is passed");
        //   var tempRefrence = firestore.collection("ManualPayment").doc(u_id);
        //   tempRefrence.set({
        //     'Course': {
        //       selectedCourse: {
        //         "isPurchased": false,
        //       }
        //     }
        //   }, SetOptions(merge: true));
        // }
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
      userId = await authService.getCurrentUser();

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
            "Sciences and Arts",
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
//            Card(
//              margin: EdgeInsets.all(8),
//              child: InkWell(
//                onTap: () {},
//                splashColor: Colors.white,
//                child: Center(
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Icon(
//                        Icons.school,
//                        size: 70,
//                      ),
//                      Text("Organic I", style: new TextStyle(fontSize: 17.0))
//                    ],
//                  ),
//                ),
//              ),
//            ),
//
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
                                    .contains('biochemistry0') ||
                                await checkmanual('biochemistry0')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChaptersBio(
                                          courseName: 'biochemistry0')));
                            } else {
                              try {
                                if (offerings
                                    .getOffering("biochemistry0")
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
                                        .getOffering("biochemistry0")
                                        .threeMonth,
                                    email: userId.email,
                                  ),
                                ),
                              );
                              print("this is the offering  : $offerings");
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
                              Text("Biochemistry",
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
                                    .contains('pathology') ||
                                await checkmanual('pathology')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChaptersBio(
                                          courseName: 'pathology')));
                            } else {
                              try {
                                if (offerings
                                    .getOffering("pathology")
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
                                                .getOffering("pathology")
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
                              Text("Pathology",
                                  style: new TextStyle(
                                      fontSize: 10, color: Colors.white)),
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
                                    .contains('organic1') ||
                                await checkmanual('organic1')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChaptersBio(courseName: 'organic1')));
                            } else {
                              try {
                                if (offerings
                                    .getOffering("organic1")
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
                                                .getOffering("organic1")
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
                              Text("organic I",
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
                                    .contains('general_chemistry') ||
                                await checkmanual('general_chemistry')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChaptersBio(
                                          courseName: 'General Chemistry')));
                            } else {
                              try {
                                if (offerings
                                    .getOffering("general_chemistry")
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
                                                .getOffering(
                                                    "general_chemistry")
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
                              Text("General Chemistry",
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
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      child: InkWell(
                        onTap: () async {
                          try {
                            if (purchaserInfo.activeSubscriptions
                                    .contains('organic2') ||
                                await checkmanual('organic2')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChaptersBio(courseName: 'organic2')));
                            } else {
                              try {
                                if (offerings
                                    .getOffering("organic2")
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
                                                .getOffering("organic2")
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
                              Text("Organic II",
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
              //             color: Colors.green,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(25.0))),
              //         child: InkWell(
              //           onTap: () {
              //             // The function showDialog<T> returns Future<T>.
              //             // Use Navigator.pop() to return value (of type T).
              //             showDialog<String>(
              //               context: context,
              //               builder: (BuildContext context) => AlertDialog(
              //                 title: const Text('Coming Soon...'),
              //                 content: Text(
              //                   'Soon',
              //                 ),
              //                 actions: <Widget>[
              //                   FlatButton(
              //                     child: Text('Cancel'),
              //                     onPressed: () =>
              //                         Navigator.pop(context, 'Cancel'),
              //                   ),
              //                   FlatButton(
              //                     child: Text('OK'),
              //                     onPressed: () => Navigator.pop(context, 'OK'),
              //                   ),
              //                 ],
              //               ),
              //             ).then((returnVal) {
              //               if (returnVal != null) {
              //                 Scaffold.of(context).showSnackBar(
              //                   SnackBar(
              //                     backgroundColor: Colors.red,
              //                     content: Text('You clicked: $returnVal'),
              //                     action: SnackBarAction(
              //                       label: 'OK',
              //                       onPressed: () {},
              //                       textColor: Colors.white,
              //                       disabledTextColor: Colors.red,
              //                     ),
              //                   ),
              //                 );
              //               }
              //             });
              //           },
              //           splashColor: Colors.black,
              //           child: Center(
              //             child: Column(
              //               mainAxisSize: MainAxisSize.min,
              //               children: <Widget>[
              //                 Icon(
              //                   Icons.book,
              //                   size: 70,
              //                   color: Colors.red,
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
              //             color: Colors.orange,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(25.0))),
              //         child: InkWell(
              //           onTap: () {
              //             // The function showDialog<T> returns Future<T>.
              //             // Use Navigator.pop() to return value (of type T).
              //             showDialog<String>(
              //               context: context,
              //               builder: (BuildContext context) => AlertDialog(
              //                 title: const Text('Coming Soon...'),
              //                 content: Text(
              //                   'Soon',
              //                 ),
              //                 actions: <Widget>[
              //                   FlatButton(
              //                     child: Text('Cancel'),
              //                     onPressed: () =>
              //                         Navigator.pop(context, 'Cancel'),
              //                   ),
              //                   FlatButton(
              //                     child: Text('OK'),
              //                     onPressed: () => Navigator.pop(context, 'OK'),
              //                   ),
              //                 ],
              //               ),
              //             ).then((returnVal) {
              //               if (returnVal != null) {
              //                 Scaffold.of(context).showSnackBar(
              //                   SnackBar(
              //                     backgroundColor: Colors.red,
              //                     content: Text('You clicked: $returnVal'),
              //                     action: SnackBarAction(
              //                       label: 'OK',
              //                       onPressed: () {},
              //                       textColor: Colors.white,
              //                       disabledTextColor: Colors.red,
              //                     ),
              //                   ),
              //                 );
              //               }
              //             });
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
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(25.0))),
              //         child: InkWell(
              //           onTap: () {
              //             // The function showDialog<T> returns Future<T>.
              //             // Use Navigator.pop() to return value (of type T).
              //             showDialog<String>(
              //               context: context,
              //               builder: (BuildContext context) => AlertDialog(
              //                 title: const Text('Coming Soon...'),
              //                 content: Text(
              //                   'Soon',
              //                 ),
              //                 actions: <Widget>[
              //                   FlatButton(
              //                     child: Text('Cancel'),
              //                     onPressed: () =>
              //                         Navigator.pop(context, 'Cancel'),
              //                   ),
              //                   FlatButton(
              //                     child: Text('OK'),
              //                     onPressed: () => Navigator.pop(context, 'OK'),
              //                   ),
              //                 ],
              //               ),
              //             ).then((returnVal) {
              //               if (returnVal != null) {
              //                 Scaffold.of(context).showSnackBar(
              //                   SnackBar(
              //                     backgroundColor: Colors.red,
              //                     content: Text('You clicked: $returnVal'),
              //                     action: SnackBarAction(
              //                       label: 'OK',
              //                       onPressed: () {},
              //                       textColor: Colors.white,
              //                       disabledTextColor: Colors.red,
              //                     ),
              //                   ),
              //                 );
              //               }
              //             });
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
              //             color: Colors.blueAccent,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(25.0))),
              //         child: InkWell(
              //           onTap: () {
              //             // The function showDialog<T> returns Future<T>.
              //             // Use Navigator.pop() to return value (of type T).
              //             showDialog<String>(
              //               context: context,
              //               builder: (BuildContext context) => AlertDialog(
              //                 title: const Text('Coming Soon...'),
              //                 content: Text(
              //                   'Soon',
              //                 ),
              //                 actions: <Widget>[
              //                   FlatButton(
              //                     child: Text('Cancel'),
              //                     onPressed: () =>
              //                         Navigator.pop(context, 'Cancel'),
              //                   ),
              //                   FlatButton(
              //                     child: Text('OK'),
              //                     onPressed: () => Navigator.pop(context, 'OK'),
              //                   ),
              //                 ],
              //               ),
              //             ).then((returnVal) {
              //               if (returnVal != null) {
              //                 Scaffold.of(context).showSnackBar(
              //                   SnackBar(
              //                     backgroundColor: Colors.red,
              //                     content: Text('You clicked: $returnVal'),
              //                     action: SnackBarAction(
              //                       label: 'OK',
              //                       onPressed: () {},
              //                       textColor: Colors.white,
              //                       disabledTextColor: Colors.red,
              //                     ),
              //                   ),
              //                 );
              //               }
              //             });
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
              //             color: Colors.teal,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(25.0))),
              //         child: InkWell(
              //           onTap: () {
              //             // The function showDialog<T> returns Future<T>.
              //             // Use Navigator.pop() to return value (of type T).
              //             showDialog<String>(
              //               context: context,
              //               builder: (BuildContext context) => AlertDialog(
              //                 title: const Text('Coming Soon...'),
              //                 content: Text(
              //                   'Soon',
              //                 ),
              //                 actions: <Widget>[
              //                   FlatButton(
              //                     child: Text('Cancel'),
              //                     onPressed: () =>
              //                         Navigator.pop(context, 'Cancel'),
              //                   ),
              //                   FlatButton(
              //                     child: Text('OK'),
              //                     onPressed: () => Navigator.pop(context, 'OK'),
              //                   ),
              //                 ],
              //               ),
              //             ).then((returnVal) {
              //               if (returnVal != null) {
              //                 Scaffold.of(context).showSnackBar(
              //                   SnackBar(
              //                     backgroundColor: Colors.red,
              //                     content: Text('You clicked: $returnVal'),
              //                     action: SnackBarAction(
              //                       label: 'OK',
              //                       onPressed: () {},
              //                       textColor: Colors.white,
              //                       disabledTextColor: Colors.red,
              //                     ),
              //                   ),
              //                 );
              //               }
              //             });
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
      ),
    );
  }
}
