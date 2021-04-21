import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  Timestamp accountCreated;
  String displayName;
  String phoneNumber;
  String photoUrl;
  String deviceId;
  UserModel(
      {this.uid,
      this.email,
      this.accountCreated,
      this.displayName,
      this.phoneNumber,
      this.photoUrl,
      this.deviceId});

  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.data()['Uid'];
    email = doc.data()['email'];
    accountCreated = doc.data()['accountCreated'];
    displayName = doc.data()['displayName'];
    phoneNumber = doc.data()['phoneNumber'];
    deviceId = doc.data()['DeviceId'];
  }
}
