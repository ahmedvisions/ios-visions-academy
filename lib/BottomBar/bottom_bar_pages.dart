import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visions_academy/SideBar/side_bar_bar_pages.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PageController _pageController;
  var selectedPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
            controller: _pageController,
            children: <Widget>[SideBar()],
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
        height: 60,
        items: <Widget>[
          InkWell(
            child: Icon(Icons.home, size: 20, color: Colors.black),
            onTap: () {
              Get.off(CustomDrawer());
            },
          ),
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
