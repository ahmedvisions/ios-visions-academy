import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String title, detail, time;
  NewsModel(this.title, this.detail, this.time);

  NewsModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    time = doc.data()['time'];
    detail = doc.data()['detail'];
    title = doc.data()['title'];
  }
}
