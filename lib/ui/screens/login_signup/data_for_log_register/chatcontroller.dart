import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database.dart';

class ChatController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();
  final Rx<ChatUser> user = ChatUser(
          name: FirebaseAuth.instance.currentUser.displayName,
          uid: FirebaseAuth.instance.currentUser.uid,
          containerColor: const Color(0xffadd8e6),
          color: Colors.black)
      .obs;
  Future<void> onSend(ChatMessage message) async {
    DocumentSnapshot userSS;
    print(message.toJson());
    userSS = await _databaseService.getSnapShot();
    var documentReference = FirebaseFirestore.instance
        .collection('messagesUser')
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .collection('msgs')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    var nameReference = FirebaseFirestore.instance
        .collection('messagesUser')
        .doc(FirebaseAuth.instance.currentUser.uid.toString());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        message.toJson(),
      );
    });
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        nameReference,
        {
          // 'name': userSS.data()["displayName"],
          'name': FirebaseFirestore.instance.collection("displayName"),
        },
      );
    });
    /* setState(() {
      messages = [...messages, message];
      print(messages.length);
    });
    if (i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    } else {
      systemMessage();
    } */
  }
}
