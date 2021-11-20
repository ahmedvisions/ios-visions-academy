import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'database.dart';
import 'users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(String email, String password, String displayName,
      String phoneNumber, String photoUrl, String deviceId1) async {
    String retVal = "error";
     try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _authResult.additionalUserInfo.profile.addAll({
        "displayName": displayName,
      });

      UserModel _user = UserModel(
        uid: _authResult.user.uid,  
        email: _authResult.user.email,
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: _authResult.user.photoURL,
        accountCreated: Timestamp.now(),
        deviceId: deviceId1, // my internet is toooooo slow
      );
      String _returnString =
          await DatabaseService().createUser(_user, deviceId1);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (error) {
      print(error.toString());
      return null;
    }
    return retVal;
  }

  User getCurrentUser() {
    return _auth.currentUser;
  }
}
