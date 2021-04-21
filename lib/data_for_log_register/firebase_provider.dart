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
        videoUrl: ds.data()['videoUrl'],
        thumbUrl: ds.data()['thumbUrl'],
        coverUrl: ds.data()['coverUrl'],
        aspectRatio: ds.data()['aspectRatio'],
        videoName: ds.data()['videoName'],
        uploadedAt: ds.data()['uploadedAt'].toDate(),
        chapter: ds.data()['chapterNo'],
        courseName: ds.data()['CourseName'],
      );
    }).toList();
  }
}
