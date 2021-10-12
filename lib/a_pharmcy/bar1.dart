import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar0 extends StatefulWidget {
  @override
  _BottomBar0State createState() => _BottomBar0State();
}

class _BottomBar0State extends State<BottomBar0> {
  PageController _pageController;
  var selectedPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    // Size size =  MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: PageView(
            controller: _pageController,
            children: <Widget>[
              //    CoursesPh()
            ],
            onPageChanged: (int index) {
              setState(() {
                _pageController.jumpToPage(index);
              });
            }),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.redAccent,
        backgroundColor: Colors.red,
        buttonBackgroundColor: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(Icons.school, size: 20, color: Colors.black),
        ],
        onTap: (int selectedPage) {
          setState(() {
            _pageController.jumpToPage(selectedPage);
          });
        },
        animationDuration: Duration(milliseconds: 850),
        animationCurve: Curves.easeInOutCubic,
      ),
    );
  }
}
