
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:visions_academy/components/widget/widget/navigation_drawer_widget.dart';
import 'package:visions_academy/ui/screens/chat/chat_screen.dart';
import 'package:visions_academy/ui/screens/home_screen/home_and_Screen/home_page.dart';
import 'package:visions_academy/ui/screens/profile_screen/profile.dart';



class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  // static const routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.person,
      //         ),
      //         label: 'Profile'),
      //   ],
      //   onTap: onTap,
      //   currentIndex: page,
      // ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blue,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.white,
          height: 60,
          items: const <Widget>[
            InkWell(
              child: Icon(Icons.home, size: 20, color: Colors.black),
            ),
          ],
          onTap: onTap,

          animationDuration: Duration(milliseconds: 850),
          animationCurve: Curves.easeInOutCubic,
        ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[ HomeScreen()
          // , Person()
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
        drawer: const NavigationDrawerWidget(),
      floatingActionButton: Builder(
        builder: (context)=>FloatingActionButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
           // Scaffold.of(context).openEndDrawer();
          },
          child:const Icon(
             Icons.menu
          ) ,
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}


