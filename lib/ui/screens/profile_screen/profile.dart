import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/database.dart';

class Person extends StatelessWidget {




  DocumentSnapshot userSS;
  final String documentId;

   Person({Key key, this.documentId}) : super(key: key);


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _displayname = "";
  String _email="";
  final DatabaseService _databaseService = DatabaseService();
  CollectionReference users = FirebaseFirestore.instance.collection('displayName');

  // initUser() async {
  //   userSS = await _databaseService.getSnapShot();
  //   if (mounted) {
  //     setState(() {
  //
  //       _displayname = firestore.collection("displayName").toString();
  //       _email =  firestore.collection("email").toString();
  //
  //
  //       // _displayname = userSS.data()["displayName"];
  //       // _email = userSS.data()["email"];
  //     });
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data.exists) {
        return const Text("Document does not exist");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
        return Text("Full Name: ${data['displayName']} ${data['email']}");
      }

      return const Text("loading");
    }
    );

  }
}
