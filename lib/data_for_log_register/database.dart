import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'users.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> createUser(UserModel user, String devId) async {
    String retVal = "error";

    try {
      await firestore.collection("users").doc(devId).set({
        'displayName': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'accountCreated': Timestamp.now(),
        'Uid': user.uid,
      });
      retVal = "success";
    } catch (error) {
      print(error.toString());
      return null;
    }

    return retVal;
  }

  Future<String> getId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  Future<DocumentSnapshot> getSnapShot() async {
    DocumentSnapshot snapshot;
    try {
      await firestore
          .collection("users")
          .doc(await getId())
          .get()
          .then((value) {
        snapshot = value;
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return snapshot;
  }
}
