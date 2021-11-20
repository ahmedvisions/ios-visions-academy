import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:visions_academy/ui/screens/course/biochemistry/chaptersbio.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/auth.dart';
 import 'package:visions_academy/ui/screens/moodlescreen/subscribtionpage/subscription_page.dart';

import '../../../../constants.dart';



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

        //

        if (dueDate.isAfter(DateTime.now().add(Duration(days: 1)))) {
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

        ////
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
          title: const Text(
            "Sciences and Arts",
          ),
          elevation: 0,
          backgroundColor: Colors.lightBlue,
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: 2000,
          padding: const EdgeInsets.all(10),
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

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 120.0,
                  child: InkWell(
                    onTap: () async {
                      try {

                        if (purchaserInfo.activeSubscriptions
                            .contains('biochemistry0') ||
                            await checkmanual('biochemistry0')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChaptersBio(
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
                          IconButton(
                            icon: Image.asset(
                                'assets/images/science1.ico'),
                            iconSize: 70,
                          ),
                          const Text("Biochemistry",
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
                            .contains('pathology') ||
                            await checkmanual('pathology')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChaptersBio(
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
                        children:  <Widget>[

                          IconButton(
                            icon: Image.asset(
                                'assets/images/science1.ico'),
                            iconSize: 70, onPressed: () {  },
                          ),
                          const Text("Pathology",
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
                  child:InkWell(
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


                          IconButton(
                            icon: Image.asset(
                                'assets/images/science1.ico'),
                            iconSize: 70, onPressed: () {  },
                          ),
                          const Text("organic I",
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
                  child:InkWell(
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
                          IconButton(
                            icon: Image.asset(
                                'assets/images/science1.ico'),
                            iconSize: 70, onPressed: () {  },
                          ),
                          const Text("General Chemistry",
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
                  child:InkWell(
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

                          IconButton(
                            icon: Image.asset(
                                'assets/images/science1.ico'),
                            iconSize: 70, onPressed: () {  },
                          ),
                          const Text("Organic II",
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
