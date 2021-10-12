import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:new_version/new_version.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visions_academy/SubscriptionPage/SubscriptionPage.dart';
import 'package:visions_academy/a_pharmcy/coursesph.dart';
import 'package:visions_academy/a_sciences/courses_sciences.dart';
import 'package:visions_academy/an_engineering/courses_engineer.dart';
import 'package:visions_academy/constants.dart';
import 'package:visions_academy/data_for_log_register/auth.dart';
import 'package:visions_academy/information/information0.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  HomeScreen({Key key, @required this.username}) : super(key: key);

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

  // _showDialog(String title, String message, BuildContext context) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (ctx) => WillPopScope(
  //           onWillPop: () async => false,
  //           child: new AlertDialog(
  //             elevation: 15,
  //             title: Text("Upgrade is available"),
  //             content:
  //                 Text("Please First upgrade you application from  playstore"),
  //             actions: [
  //               RaisedButton(
  //                 onPressed: () async {
  //                   final urlString =
  //                       "https://play.google.com/store/apps/details?id=com.visionsacademy.visions_academy";
  //                   if (await canLaunch(urlString)) await launch(urlString);
  //                   SystemNavigator.pop();
  //                 },
  //                 child: Text("Upgrade"),
  //               ),
  //             ],
  //           )));
  // }

  // bool isAvailableUpdate;
  Future<void> checkNewVersion() async {
    final newVersion = NewVersion(
      androidId: 'com.visionsacademy.visions_academy',
    );
    // final status = await newVersion.getVersionStatus();
    // // isAvailableUpdate = status.canUpdate;

    // print(status.canUpdate.toString() +
    //     status.localVersion +
    //     " :  " +
    //     status.storeVersion +
    //     ": " +
    //     status.appStoreLink);
    // Future.delayed(Duration.zero, () {
    //   // if (isAvailableUpdate) {
    //   //   //  _showDialog("Upgrade is available", "", context);//TODO plese uncomit this line for upgrade check
    //   //   //          title: "Update Available ",content:Text("Please Update Visions Academy application from play store")
    //   //   //  );
    //   // }
    // });
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
    Size size = MediaQuery.of(context).size;
    Color primaryColor = Color.fromRGBO(255, 40, 48, 1);
    checkNewVersion();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(color: primaryColor)),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, right: 15.0, left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconBadge(
                        itemCount: 2,
                        badgeColor: Colors.yellow,
                        icon: Icon(Icons.notifications_none),
                        itemColor: Colors.black,
                        onTap: () {
                          Navigator.pushNamed(context, '/News');
                        },
                      )
                    ],
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: CustomShapeClipper(),
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(color: primaryColor),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 1.0),
                            Text(
                              'Visions Academy',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            )
                          ],
                        ),
                        Material(
                          elevation: 50.0,
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.white,
                          child: MaterialButton(
                            onPressed: () {
//                               showDialog<String>(
//                                 context: context,
//                                 builder: (BuildContext context) => AlertDialog(
//                                   title: const Text('Coming Soon...'),
//                                   content: Text(
//                                     'Soon',
//                                   ),
//                                   actions: <Widget>[
//                                     FlatButton(
//                                       child: Text('Cancel'),
//                                       onPressed: () =>
//                                           Navigator.pop(context, 'Cancel'),
//                                     ),
//                                     FlatButton(
//                                       child: Text('OK'),
//                                       onPressed: () =>
//                                           Navigator.pop(context, 'OK'),
//                                     ),
//                                   ],
//                                 ),
//                               ).then((returnVal) {
//                                 if (returnVal != null) {
//                                   Scaffold.of(context).showSnackBar(
//                                     SnackBar(
//                                       backgroundColor: Colors.red,
//                                       content: Text('You clicked: $returnVal'),
//                                       action: SnackBarAction(
//                                         label: 'OK',
//                                         onPressed: () {},
//                                         textColor: Colors.white,
//                                         disabledTextColor: Colors.red,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               });
// //                              Navigator.of(context).push(MaterialPageRoute(
// //                                  builder: (BuildContext context) => CharactersListScreen()));
                            },
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Text(
                              'Essay',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 60.0, right: 25.0, left: 25.0),
                    child: Container(
                      width: double.infinity,
                      height: 360,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0.0, 3.0),
                                blurRadius: 15.0)
                          ]),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Material(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colors.purple.withOpacity(0.1),
                                      child: IconButton(
                                        padding: EdgeInsets.all(15.0),
                                        icon: Icon(Icons.school),
                                        color: Colors.purple,
                                        iconSize: 30.0,
                                        onPressed: () async {
                                          try {
                                            if (purchaserInfo
                                                    .activeSubscriptions
                                                    .contains('moodle') ||
                                                await checkmanual(
                                                    'moodle')) // this check is for organic_1 .
                                            {
                                              Navigator.pushNamed(
                                                  context, "/Moodle");
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
                                                            // package: offerings
                                                            //     .getOffering(
                                                            //         "moodle")
                                                            //     .threeMonth,
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
                                    SizedBox(height: 8.0),
                                    Text('Moodle',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
/*                                Column(
                                  children: <Widget>[
                                    Material(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colors.blue.withOpacity(0.1),
                                      child: IconButton(
                                        padding: EdgeInsets.all(15.0),
                                        icon: Icon(Icons.school),
                                        color: Colors.blue,
                                        iconSize: 30.0,
                                        onPressed: () async {
                                          //   try {
                                          //     if (purchaserInfo
                                          //             .activeSubscriptions
                                          //             .contains('calculus_1') ||
                                          //         await checkmanual(
                                          //             'calculus_1')) {
                                          //       Navigator.push(
                                          //           context,
                                          //           MaterialPageRoute(
                                          //               builder: (context) =>
                                          //                   ChaptersOr(
                                          //                       courseName:
                                          //                           'calculus_1')));
                                          //     } else {
                                          //       try {
                                          //         if (offerings
                                          //             .getOffering("calculus_1")
                                          //             .availablePackages
                                          //             .isNotEmpty) {
                                          //           package = offerings
                                          //               .current.threeMonth;
                                          //
                                          //           // Display packages for sale
                                          //         }
                                          //       } on PlatformException catch (e) {
                                          //         // optional error handling
                                          //         print(e.toString());
                                          //       }
                                          //       Navigator.push(
                                          //           context,
                                          //           MaterialPageRoute(
                                          //               builder: (context) =>
                                          //                   SubscriptionPage(
                                          //                     offerings:
                                          //                         offerings,
                                          //                     purchaserInfo:
                                          //                         purchaserInfo,
                                          //                     package: offerings
                                          //                         .getOffering(
                                          //                             "calculus_1")
                                          //                         .threeMonth,
                                          //                     email: userId.email,
                                          //                   )));
                                          //       print(offerings);
                                          //     }
                                          //   } catch (e) {
                                          //     print("Problem is :   " +
                                          //         e.toString());
                                          //   }
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text('Soon...',
                                        style: TextStyle(
                                            //   fontSize: 13,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold))
                                  ],
                                )*/
/*
                                Column(
                                  children: <Widget>[
                                    Material(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colors.orange.withOpacity(0.1),
                                      child: IconButton(
                                        padding: EdgeInsets.all(15.0),
                                        icon: Icon(Icons.school),
                                        color: Colors.orange,
                                        iconSize: 30.0,
                                        onPressed: () async {
                                          // try {
                                          //   if (purchaserInfo
                                          //           .activeSubscriptions
                                          //           .contains('statistics') ||
                                          //       await checkmanual(
                                          //           'statistics')) {
                                          //     Navigator.pushNamed(context,
                                          //         "/Chaptersstatistics");
                                          //   } else {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 SubscriptionPage(
                                          //                   offerings:
                                          //                       offerings,
                                          //                   purchaserInfo:
                                          //                       purchaserInfo,
                                          //                   package: offerings
                                          //                       .getOffering(
                                          //                           "statistics")
                                          //                       .sixMonth,
                                          //                   email: userId.email,
                                          //                 )));
                                          //     print(offerings);
                                          //   }
                                          // } catch (e) {
                                          //   print("Problem is :   " +
                                          //       e.toString());
                                          // }
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text('Soon... ',
                                        softWrap: true,
                                        style: TextStyle(
                                            //     fontSize: 10,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold)),
                                    // Text('...',
                                    //     style: TextStyle(
                                    //         fontSize: 10,
                                    //         color: Colors.black54,
                                    //         fontWeight: FontWeight.bold))
                                  ],
                                )
*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                    // children: <Widget>[
                                    //   Material(
                                    //     borderRadius:
                                    //         BorderRadius.circular(100.0),
                                    //     color: Colors.pink.withOpacity(0.1),
                                    //     child: IconButton(
                                    //       padding: EdgeInsets.all(15.0),
                                    //       icon: Icon(Icons.airplanemode_inactive),
                                    //       color: Colors.pink,
                                    //       iconSize: 30.0,
                                    //       onPressed: () async {
                                    //         // try {
                                    //         //   if (purchaserInfo
                                    //         //           .activeSubscriptions
                                    //         //           .contains('test') ||
                                    //         //       await checkmanual('test')) {
                                    //         //     Navigator.pushNamed(
                                    //         //         context, "/News");
                                    //         //   } else {
                                    //         //     Navigator.push(
                                    //         //         context,
                                    //         //         MaterialPageRoute(
                                    //         //             builder: (context) =>
                                    //         //                 SubscriptionPage(
                                    //         //                   offerings:
                                    //         //                       offerings,
                                    //         //                   purchaserInfo:
                                    //         //                       purchaserInfo,
                                    //         //                   package: offerings
                                    //         //                       .getOffering(
                                    //         //                           "test")
                                    //         //                       .weekly,
                                    //         //                   email: userId.email,
                                    //         //                 )));
                                    //         //   }
                                    //         // } catch (e) {
                                    //         //   print(
                                    //         //       "Problem :   " + e.toString());
                                    //         // }
                                    //       },
                                    //     ),
                                    //   ),
                                    //   SizedBox(height: 8.0),
                                    //   Text('Soon...',
                                    //       style: TextStyle(
                                    //           color: Colors.black54,
                                    //           fontWeight: FontWeight.bold))
                                    // ],
                                    ),
                                // Column(
                                //   children: <Widget>[
                                //     Material(
                                //       borderRadius:
                                //           BorderRadius.circular(100.0),
                                //       color:
                                //           Colors.purpleAccent.withOpacity(0.1),
                                //       child: IconButton(
                                //         padding: EdgeInsets.all(15.0),
                                //         icon: Icon(Icons.airplanemode_inactive),
                                //         color: Colors.purpleAccent,
                                //         iconSize: 30.0,
                                //         onPressed: () {
                                //           showDialog<String>(
                                //             context: context,
                                //             builder: (BuildContext context) =>
                                //                 AlertDialog(
                                //               title:
                                //                   const Text('Coming Soon...'),
                                //               content: Text(
                                //                 'Soon',
                                //               ),
                                //               actions: <Widget>[
                                //                 FlatButton(
                                //                   child: Text('Cancel'),
                                //                   onPressed: () =>
                                //                       Navigator.pop(
                                //                           context, 'Cancel'),
                                //                 ),
                                //                 FlatButton(
                                //                   child: Text('OK'),
                                //                   onPressed: () =>
                                //                       Navigator.pop(
                                //                           context, 'OK'),
                                //                 ),
                                //               ],
                                //             ),
                                //           ).then((returnVal) {
                                //             if (returnVal != null) {
                                //               Scaffold.of(context).showSnackBar(
                                //                 SnackBar(
                                //                   backgroundColor: Colors.red,
                                //                   content: Text(
                                //                       'You clicked: $returnVal'),
                                //                   action: SnackBarAction(
                                //                     label: 'OK',
                                //                     onPressed: () {},
                                //                     textColor: Colors.white,
                                //                     disabledTextColor:
                                //                         Colors.red,
                                //                   ),
                                //                 ),
                                //               );
                                //             }
                                //           });
                                //         },
                                //       ),
                                //     ),
                                //     SizedBox(height: 8.0),
                                //     Text('Soon...',
                                //         style: TextStyle(
                                //             color: Colors.black54,
                                //             fontWeight: FontWeight.bold))
                                //   ],
                                // ),
                                // Column(
                                //   children: <Widget>[
                                //     Material(
                                //       borderRadius:
                                //           BorderRadius.circular(100.0),
                                //       color: Colors.deepPurple.withOpacity(0.1),
                                //       child: IconButton(
                                //         padding: EdgeInsets.all(15.0),
                                //         icon: Icon(Icons.airplanemode_inactive),
                                //         color: Colors.deepPurple,
                                //         iconSize: 30.0,
                                //         onPressed: () {
                                //           showDialog<String>(
                                //             context: context,
                                //             builder: (BuildContext context) =>
                                //                 AlertDialog(
                                //               title:
                                //                   const Text('Coming Soon...'),
                                //               content: Text(
                                //                 'Soon',
                                //               ),
                                //               actions: <Widget>[
                                //                 FlatButton(
                                //                   child: Text('Cancel'),
                                //                   onPressed: () =>
                                //                       Navigator.pop(
                                //                           context, 'Cancel'),
                                //                 ),
                                //                 FlatButton(
                                //                   child: Text('OK'),
                                //                   onPressed: () =>
                                //                       Navigator.pop(
                                //                           context, 'OK'),
                                //                 ),
                                //               ],
                                //             ),
                                //           ).then((returnVal) {
                                //             if (returnVal != null) {
                                //               Scaffold.of(context).showSnackBar(
                                //                 SnackBar(
                                //                   backgroundColor: Colors.red,
                                //                   content: Text(
                                //                       'You clicked: $returnVal'),
                                //                   action: SnackBarAction(
                                //                     label: 'OK',
                                //                     onPressed: () {},
                                //                     textColor: Colors.white,
                                //                     disabledTextColor:
                                //                         Colors.red,
                                //                   ),
                                //                 ),
                                //               );
                                //             }
                                //           });
                                //         },
                                //       ),
                                //     ),
                                //     SizedBox(height: 8.0),
                                //     Text('Soon...',
                                //         style: TextStyle(
                                //             color: Colors.black54,
                                //             fontWeight: FontWeight.bold))
                                //   ],
                                // )
                              ],
                            ),
                          ),
                          //    SizedBox(height: 1.0),
                          Divider(),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Some information about Visions academy',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 50.0),
                                Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenVideo1()));
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: size.height / 13,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Text(
                    'Subjects and Courses',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 35, top: 25),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 125.0,
                        width: double.infinity,
                        child: ListView(
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Container(
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  child: InkWell(
                                    onTap: () {
                                      // if (purchaserInfo.activeSubscriptions
                                      //         .contains('pharmacology_1') ||
                                      //     await checkmanual('pharmacology_1')) {
                                      //   Navigator.pushNamed(
                                      //       context, "/CoursesPh");
                                      // } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CoursesPh()));
                                      //                 offerings: offerings,
                                      //                 purchaserInfo:
                                      //                     purchaserInfo,
                                      //                 package: offerings
                                      //                     .getOffering(
                                      //                         "pharmacology_1")
                                      //                     .sixMonth,
                                      //                 email: userId.email,
                                      //               )));
                                      //    }
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
                                          Text("Pharmacy and",
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black)),
                                          Text("Nursing",
                                              style:
                                                  new TextStyle(fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Container(
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CoursesEngineer()));
                                    },
                                    splashColor: Colors.brown,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.book,
                                            size: 70,
                                            color: Colors.white,
                                          ),
                                          Text("Engineering and",
                                              style: new TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.indigo)),
                                          Text(" architecture",
                                              style: new TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.indigo)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Container(
                                  width: 110.0,
                                  decoration: BoxDecoration(
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CoursesSciences()));
                                    },
                                    splashColor: Colors.white,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.book,
                                            size: 70,
                                            color: Colors.white,
                                          ),
                                          Text(" Sciences and",
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white)),
                                          Text(" Arts ",
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(right: 15.0),
                              //   child: Container(
                              //     width: 120.0,
                              //     decoration: BoxDecoration(
                              //         color: Colors.blue,
                              //         borderRadius: BorderRadius.all(
                              //             Radius.circular(25.0))),
                              //     child: InkWell(
                              //       onTap: () {
                              //         showDialog<String>(
                              //           context: context,
                              //           builder: (BuildContext context) =>
                              //               AlertDialog(
                              //             title: const Text('Coming Soon...'),
                              //             content: Text(
                              //               'Soon',
                              //             ),
                              //             actions: <Widget>[
                              //               FlatButton(
                              //                 child: Text('Cancel'),
                              //                 onPressed: () => Navigator.pop(
                              //                     context, 'Cancel'),
                              //               ),
                              //               FlatButton(
                              //                 child: Text('OK'),
                              //                 onPressed: () =>
                              //                     Navigator.pop(context, 'OK'),
                              //               ),
                              //             ],
                              //           ),
                              //         ).then((returnVal) {
                              //           if (returnVal != null) {
                              //             Scaffold.of(context).showSnackBar(
                              //               SnackBar(
                              //                 backgroundColor: Colors.red,
                              //                 content: Text(
                              //                     'You clicked: $returnVal'),
                              //                 action: SnackBarAction(
                              //                   label: 'OK',
                              //                   onPressed: () {},
                              //                   textColor: Colors.white,
                              //                   disabledTextColor: Colors.red,
                              //                 ),
                              //               ),
                              //             );
                              //           }
                              //         });
                              //       },
                              //       splashColor: Colors.black,
                              //       child: Center(
                              //         child: Column(
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: <Widget>[
                              //             Icon(
                              //               Icons.book,
                              //               size: 70,
                              //               color: Colors.amber,
                              //             ),
                              //             Text("SOON...",
                              //                 style:
                              //                     new TextStyle(fontSize: 17))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ]),
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

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 390.0 - 200);
    path.quadraticBezierTo(size.width / 2, 400, size.width, 390.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
