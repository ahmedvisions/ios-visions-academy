import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.amberAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

String uniqueId = "Unknown";
String platformImei = 'Unknown';
final String publicKeyRevenuCat = "czQXvObozQEFqrYfVRCIxSxvsBNohLNN";
String u_id;
Color SimpleButtonColors = const Color(0xffd50000);
Color SimpleButtonColors2 = const Color(0xff4592af);
Color BackGroundcolor = const Color(0xffffffff);
const TextStyle cardTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
Widget drawNewsDataCard(String title, String desc, String time) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
              child: Icon(
                Icons.notifications,
                color: Colors.redAccent,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 7),
                Text(desc),
                SizedBox(height: 5),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

showAlertDialog(BuildContext context, String title, String disc) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(disc),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// these are some required fuctions for restore purchasing and others
void restorePurchase() async {
  try {
    PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
// ... check restored purchaserInfo to see if entitlement is now active
  } on PlatformException catch (e) {
// Error restoring purchases
  }
}

void purchasePackage(Package package) async {
  try {
    PurchaserInfo purchaserInfo = await Purchases.purchasePackage(package);
    if (purchaserInfo.entitlements.all["my_entitlement_identifier"].isActive) {
// Unlock that great "pro" content
    }
  } on PlatformException catch (e) {
    var errorCode = PurchasesErrorHelper.getErrorCode(e);
    if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
      print(e.toString());
    }
  }
}
