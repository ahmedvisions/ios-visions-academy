import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visions_academy/BottomBar/bottom_bar_pages.dart';
import '../Home_and_Screen/home_page.dart';
import '../constants.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// ignore: must_be_immutable
class SubscriptionPage extends StatelessWidget {
  final PurchaserInfo purchaserInfo;
  final Offerings offerings;
  var package;
  final String email;

  SubscriptionPage(
      {Key key, this.purchaserInfo, this.offerings, this.package, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackGroundcolor,
        appBar: AppBar(
          title: Text(
            "Subscription page",
          ),
          backgroundColor: SimpleButtonColors,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: offerGrid(
              context,
              "Vision Academy",
              // package.product.title,
              email,
              package.product.description,
              package.product.price,
              package,
              package.product.identifier,
            ),
          ),
        ));
  }
}

Widget offerGrid(
  BuildContext context,
  String name,
  String email,
  String description,
  double price,
  Package package,
  String selectedCourse,
) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String isrequestAlready;

  Future<bool> checkFirstTime() async {
    bool a;
    try {
      await firestore
          .collection("ManualPayment")
          .doc(u_id)
          .get()
          .then((value) => {a = !value.exists});
    } catch (e) {
      a = true;
    }
    return a;
  }

  Future<void> addnewUser() async {
    await firestore.collection("ManualPayment").doc(u_id).set({
      "Course": {
        selectedCourse: {
          "isPurchased": false,
          "StartDate": null,
          "DueDate": null,
        }
      },
      "Email": email,
      "uid": u_id,
      "time": DateTime.now().toLocal().toString()
    }, SetOptions(merge: true)).then((_) {
      showAlertDialog(context, "Alert",
          "You have applied for manual payment.please wait for admin approval.");
    });
  }

  return Column(
    children: [
      Container(
        child: ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: SimpleButtonColors),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Image.asset(
                        'assets/1/2.png',
                        fit: BoxFit.cover,
                      ),
                      margin: new EdgeInsets.all(0),
                      padding: new EdgeInsets.all(0),
                      color: Colors.blueGrey[100],
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 2.5,
                      //child: Image.asset("images/logoAiksol.png"),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(description,
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 15)),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
      // Container(
      //   width: MediaQuery.of(context).size.width / 1.2,
      //   child: RaisedButton(
      //     color: SimpleButtonColors,
      //     onPressed: () async {
      //       try {
      //         Purchases.purchasePackage(package).then((v) async {
      //           // wow                // var firebaseUser = await FirebaseAuth.instance.currentUser();
      //           await firestore
      //               // user id of loggedin user
      //               .collection("RevenuePayment")
      //               .doc(
      //                   u_id) // make new manual payment collection in user collection
      //               .set({
      //             // add these information
      //             "Course": selectedCourse,
      //             "uid": u_id,
      //             // Course on which user selected
      //             "StartDate": v.originalPurchaseDate,
      //             // i make it null in customer app because we will make check for requests and approved users
      //             "DueDate": v.latestExpirationDate,
      //             // there will be calculated date if three month or six month
      //             "time": DateTime.now().toLocal().toString()
      //           });
      //         });
      //         await Purchases.syncPurchases();
      //       } on PlatformException catch (e) {
      //         var errorCode = PurchasesErrorHelper.getErrorCode(e);
      //         if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
      //           print("User cancelled");
      //         } else if (errorCode ==
      //             PurchasesErrorCode.purchaseNotAllowedError) {
      //           print("User not allowed to purchase");
      //         }
      //       }
      //       return BottomBar();
      //     },
      //     child: Container(
      //         child: Center(
      //             child: Text("Buy - (${package.product.priceString})"))),
      //   ),
      // ),
      // Container(
      //   child: Center(
      //     child: Text("Or"),
      //   ),
      // ),
      Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: RaisedButton(
            color: SimpleButtonColors,
            onPressed: () async {
              if (await checkFirstTime()) {
                await addnewUser();
              } else {
                await firestore
                    .collection("ManualPayment")
                    .doc(u_id)
                    .get()
                    .then((value) {
                  try {
                    isrequestAlready = value
                        .data()["Course"][selectedCourse]["isPurchased"]
                        .toString();
                  } catch (e) {
                    print("Course not found");
                    isrequestAlready = 'null';
                  }
                });

                if (u_id != null) {
                  if (isrequestAlready != 'false') {
                    // var firebaseUser = await FirebaseAuth.instance.currentUser();
                    await firestore
                        .collection("ManualPayment")
                        .doc(u_id)
                        .update(
                      {
                        "Course.$selectedCourse": {
                          "isPurchased": false,
                          "StartDate": null,
                          "DueDate": null,
                        },
                        "Email": email,
                        "uid": u_id,
                        "time": DateTime.now().toLocal().toString()
                      },
                    ).then((_) {
                      showAlertDialog(context, "Alert",
                          "You have applied for mannual payment.please wait for admin approval.");
                    });
                  } else {
                    showAlertDialog(context, "Alert",
                        "You already have Requested for manual Payment. please contact admin.");
                  }
                }
                if (isrequestAlready == null) {
                } else
                  print(isrequestAlready);
              }
            },
            child: Container(
              child: Center(child: Text("I am a successful student")),
            ),
          ))
    ],
  );
}
