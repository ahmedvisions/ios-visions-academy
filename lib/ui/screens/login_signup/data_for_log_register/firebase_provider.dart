import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visions_academy/Model/video_info.dart';

class FirebaseProvider {
  static saveVideo(
    VideoInfo video,
  ) async {
    await FirebaseFirestore.instance.collection("Videos").doc().set({
      'videoUrl': video.videoUrl,
      'thumbUrl': video.thumbUrl,
      'coverUrl': video.coverUrl,
      'aspectRatio': video.aspectRatio,
      'uploadedAt': video.uploadedAt,
      'videoName': video.videoName,
      'chapterNo': video.chapter,
      'CourseName': video.courseName,
    });
  }

  static listenToVideos(callback, String courseName, int chaptNo) async {
    FirebaseFirestore.instance
        .collection("Videos")
        .where('CourseName', isEqualTo: courseName)
        .where('chapterNo', isEqualTo: chaptNo)
        .snapshots()
        .listen((qs) {
      final videos = mapQueryToVideoInfo(qs);
      callback(videos);
    });
  }

  static mapQueryToVideoInfo(QuerySnapshot qs) {
    return qs.docs.map((DocumentSnapshot ds) {
      return VideoInfo(
        // videoUrl: FirebaseFirestore.instance.collection("videoUrl").toString(),
        // thumbUrl: FirebaseFirestore.instance.collection("thumbUrl").toString(),
        // coverUrl: FirebaseFirestore.instance.collection("coverUrl").toString(),
        // aspectRatio:
        //     FirebaseFirestore.instance.collection("aspectRatio") as double,

        // videoName:
        //     FirebaseFirestore.instance.collection("videoName").toString(),
        // uploadedAt: FirebaseFirestore.instance
        //     .collection("uploadedAt")
        //     .toString() as DateTime,
        // chapter: FirebaseFirestore.instance.collection("chapterNo").toString()
        //     as int,
        // courseName:
        //     FirebaseFirestore.instance.collection("CourseName").toString(),
        videoUrl:
        ds.data().toString().contains('videoUrl') ? ds.get('videoUrl') : '',
        thumbUrl:
        ds.data().toString().contains('thumbUrl') ? ds.get('thumbUrl') : '',
        coverUrl:
        ds.data().toString().contains('coverUrl') ? ds.get('coverUrl') : '',
        aspectRatio: ds.data().toString().contains('aspectRatio')
            ? ds.get('aspectRatio')
            : '',
        videoName: ds.data().toString().contains('videoName')
            ? ds.get('videoName')
            : '',
        // uploadedAt: ds.data().toString().contains('uploadedAt')
        //     ? ds.get('uploadedAt')
        //     : '',
        chapter: ds.data().toString().contains('chapterNo')
            ? ds.get('chapterNo')
            : '',
        courseName: ds.data().toString().contains('CourseName')
            ? ds.get('CourseName')
            : '',
        // videoUrl: ds.get('videoUrl'),
        // thumbUrl: ds.get('thumbUrl'),
        // coverUrl: ds.get('coverUrl'),
        // aspectRatio: ds.get('aspectRatio'),
        // videoName: ds.get('videoName'),
        // uploadedAt: ds.get('uploadedAt').toDate(),
        // chapter: ds.get('chapterNo'),
        // courseName: ds.get('CourseName'),
      );
    }).toList();
  }
}
