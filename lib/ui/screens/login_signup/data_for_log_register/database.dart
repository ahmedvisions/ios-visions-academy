import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'users.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> createUser(UserModel user, String devId) async {
    String retVal = "error";

    try {
      await firestore.collection("users").doc(user.uid).set({
        'displayName': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'accountCreated': Timestamp.now(),
        'deviceID': devId,
      });
      retVal = "success";
    } catch (error) {
      print(error.toString());
      return null;
    }

    return retVal;
  }
  Future<String> loginUser(String uid, String devId) async {
    String retVal = "error";

    try {
      await firestore.collection("users").doc(uid).update({
        'deviceID': devId,
      });
    } catch (error) {
      print(error);
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
          .doc(FirebaseAuth.instance.currentUser.uid)
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
  Future<UserModel> getUserData() async {
    UserModel userModel;
    try {
      await firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        print('---------------------------------');
        print(value.data()['displayName']);
        print(value.data()['email']);
        print(value.data()['deviceID']);
        userModel = new UserModel(
            uid: FirebaseAuth.instance.currentUser.uid,
            displayName: value.data()['displayName'],
            email: value.data()['email'],
            phoneNumber: value.data()['phoneNumber'],
            accountCreated: value.data()['accountCreated'],
            deviceId: value.data()['deviceID']);
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return userModel;
  }

  Future<String> getDevIdFromDatabase() async {
    String deviceID;
    try {
      await firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        deviceID = value.data()['deviceID'];
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return deviceID;
  }
}
