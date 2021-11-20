
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visions_academy/Model/newsa_model.dart';

import '../../../constants.dart';


class NotfactionScreen extends StatefulWidget {

  @override
  State<NotfactionScreen> createState() => _NotfactionScreenState();
}

class _NotfactionScreenState extends State<NotfactionScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<NewsModel> newsList = [];
  List<NewsModel> notificationList = [];

  void populateNewsList() async {
    newsList.clear();

    await firebaseFirestore.collection("news").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        NewsModel obj = NewsModel(result.get('title'), result.get('detail'),
            result.get('time').toString());
        print(result.get('time').toString());
        newsList.add(obj);
        setState(() {});
        //newsList.add(result.get('Title')+'\,'result.get('Details')+'\,' result.get('Time'));
      });
    });
    notificationList.clear();
    await firebaseFirestore
        .collection("notification")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        NewsModel obj = NewsModel(result.get('title'), result.get('detail'),
            result.get('time').toString());

        notificationList.add(obj);
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    populateNewsList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("notification"),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: <Widget>[
          // ClipPath(
          //   // clipper: CustomShapeClipper(),
          //   child: Container(
          //     height: 350.0,
          //     decoration: BoxDecoration(color: SimpleButtonColors),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 5),
                    const Text(
                      "Latest News",
                      // style: cardTitleTextStyle,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: size.height * 0.38,
                      width: size.width / 1.1,
                      decoration:  BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            //                   <--- left side
                            color:  Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                          top: BorderSide(
                            //                    <--- top side
                            color:  Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                          right: BorderSide(
                            //                    <--- top side
                            color: Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                          bottom:  BorderSide(
                            //                    <--- top side
                            color: Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          //shrinkWrap: true,
                          itemCount: newsList.length,
                          itemBuilder: (context, int index) {
                            return  Padding(
                              padding: const EdgeInsets.all(2.0),
                               child: drawNewsDataCard(newsList[index].title,
                                   newsList[index].detail, newsList[index].time),
                            );
                          }),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Latest Notifications",
                      // style: cardTitleTextStyle,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: size.height * 0.35,
                      width: size.width / 1.1,
                      decoration:  BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            //                   <--- left side
                            color:  Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                          top: BorderSide(
                            //                    <--- top side
                            color:  Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                          right: BorderSide(
                            //                    <--- top side
                            color: Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                          bottom:  BorderSide(
                            //                    <--- top side
                            color: Colors.blueAccent.shade100,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: notificationList.length,
                          itemBuilder: (context, int index) {
                            return  Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: drawNewsDataCard(
                                  notificationList[index].title,
                                  notificationList[index].detail,
                                  notificationList[index].time),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}