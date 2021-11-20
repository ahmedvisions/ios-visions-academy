import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:visions_academy/Model/video_info.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/firebase_provider.dart';
import 'package:visions_academy/ui/screens/organic_test/player.dart';


class UpVid2 extends StatefulWidget {
  final String coursename;
  final int chapt;
  // In the constructor, require a RecordObject.
  UpVid2({Key key, this.coursename, this.chapt}) : super(key: key);
  @override
  _UpVid2State createState() => _UpVid2State();
}

class _UpVid2State extends State<UpVid2> {
  final thumbWidth = 100;
  final thumbHeight = 150;
  List<VideoInfo> _videos = <VideoInfo>[];

  bool _processing = false;
  double _progress = 0.0;
  String _processPhase = '';

  @override
  void initState() {
    print("[ Course name is: ]" + widget.coursename);

    FirebaseProvider.listenToVideos((newVideos) {
      setState(() {
        _videos = newVideos;
      });
    }, widget.coursename, widget.chapt);

    super.initState();
  }

  String getFileExtension(String fileName) {
    final exploded = fileName.split('.');
    return exploded[exploded.length - 1];
  }

  _getListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _videos.length,
        itemBuilder: (BuildContext context, int index) {
          final video = _videos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return VidPlayer(
                      video: video,
                    );
                  },
                ),
              );
            },
            child: Card(
              child:  Container(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: thumbWidth.toDouble(),
                              height: thumbHeight.toDouble(),
                              child: const Center(child: CircularProgressIndicator()),
                            ),
                            SizedBox(
                              width: thumbWidth.toDouble(),
                              height: thumbHeight.toDouble(),
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(8.0),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image:
                                      //  video.thumbUrl != null
                                      //     ? video.thumbUrl
                                      //     :
                                      'https://picsum.photos/200/300',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text("${video.videoName}"),
                                Container(
                                  margin: const EdgeInsets.only(top: 12.0),
                                  child: const Text('Uploaded'
                                      // ${timeago.format(video.uploadedAt)}
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _getProgressBar() {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 30.0),
            child: Text(_processPhase),
          ),
          LinearProgressIndicator(
            value: _progress,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _processing ? _getProgressBar() : _getListView()),
    );
  }
}
