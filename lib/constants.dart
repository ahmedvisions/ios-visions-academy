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
const String publicKeyRevenuCat = "czQXvObozQEFqrYfVRCIxSxvsBNohLNN";



String u_id;
const simpleButtonColors =  Color(0xff5596ea);
const simpleButtonColors2 =  Color(0xff4592af);
const back_groundcolor =  Color(0xffffffff);

const kTextColor = Color(0xFF0D1333);
const kBlueColor = Color(0xFF6E8AFA);
const kBestSellerColor = Color(0xFFFFD073);
const kGreenColor = Color(0xFF49CC96);
const TextStyle cardTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);


// My Text Styles
const kHeadingextStyle = TextStyle(
  fontSize: 28,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
const kSubheadingextStyle = TextStyle(
  fontSize: 24,
  color: Color(0xFF61688B),
  height: 2,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextSyule = TextStyle(
  fontSize: 18,
  color: kTextColor,
  // fontWeight: FontWeight.bold,
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
            const SizedBox(
              width: 30,
              child: Icon(
                Icons.notifications,
                color: Colors.redAccent,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 7),
                Text(desc),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
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
    child: const Text("OK"),
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
