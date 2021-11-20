import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String title, detail, time;
  NewsModel(this.title, this.detail, this.time);

  NewsModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    time = FirebaseFirestore.instance.collection("time").toString();
    detail = FirebaseFirestore.instance.collection("detail").toString();
    title = FirebaseFirestore.instance.collection("title").toString();
  }
}
