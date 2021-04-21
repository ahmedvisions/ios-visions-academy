import 'package:flutter/material.dart';
import 'package:visions_academy/organic1/screen_video1.dart';
import '../constants.dart';

class ChaptersOr extends StatefulWidget {
  final String courseName;

  const ChaptersOr({Key key, this.courseName}) : super(key: key);

  @override
  _ChaptersOrState createState() => _ChaptersOrState();
}

class _ChaptersOrState extends State<ChaptersOr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapters'),
        elevation: 20,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 20.0,
                  color: SimpleButtonColors,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenVideo(
                                    courseName: widget.courseName,
                                    chaptNo: 1,
                                  )));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Chapter 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 20.0,
                  child: MaterialButton(
                    elevation: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenVideo(
                                    courseName: widget.courseName,
                                    chaptNo: 2,
                                  )));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Chapter 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.limeAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 20.0,
                  child: MaterialButton(
                    elevation: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenVideo(
                                courseName: widget.courseName,
                                chaptNo: 3,
                              )));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Chapter 3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 20.0,
                  child: MaterialButton(
                    elevation: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenVideo(
                                courseName: widget.courseName,
                                chaptNo: 4,
                              )));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Chapter 4',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 20.0,
                  child: MaterialButton(
                    elevation: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenVideo(
                                courseName: widget.courseName,
                                chaptNo: 5,
                              )));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Chapter 5',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 20.0,
                  child: MaterialButton(
                    elevation: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenVideo(
                                courseName: widget.courseName,
                                chaptNo: 6,
                              )));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Chapter 6',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
