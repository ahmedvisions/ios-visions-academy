import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:get/get.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:visions_academy/Home_and_Screen/home_page.dart';
import 'package:visions_academy/Home_and_Screen/news.dart';
import 'package:visions_academy/constants.dart';
import 'package:visions_academy/data_for_log_register/database.dart';
import 'package:visions_academy/ChatScreen.dart';
import 'package:visions_academy/register_login/login.dart';

Rx<Widget> currentWidget = HomeScreen(
  username: "Visions Academy",
).obs;

class CustomDrawer extends StatefulWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  DocumentSnapshot userSS;
  @override
  void initState() {
    super.initState();
    initUser();
  }

  String _displayname = "", _email;
  DatabaseService _databaseService = new DatabaseService();
  initUser() async {
    userSS = await _databaseService.getSnapShot();
    if (mounted)
      setState(() {
        _displayname = userSS.data()["displayName"];
        _email = userSS.data()["email"];
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: Get.width * 0.60,
        height: Get.height,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    UserAccountsDrawerHeader(
                      accountName: Text(_displayname,
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 18)),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: AssetImage(
                            'assets/1/2.png',
                          ),
                        ),
                      ),
                      accountEmail: Text("$_email",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 14)),
                    ),
                  ]),
            ),
            ListTile(
              onTap: () {
                currentWidget = HomeScreen(
                  username: "Visions Academy",
                ).obs;
                widget.closeDrawer();
                isChatOpen = true;
                if (mounted) setState(() {});
//              Navigator.of(context).push(
//                  MaterialPageRoute(builder: (context) => ProfileView()));
//              widget.closeDrawer();
              },
              leading: Icon(Icons.person),
              title: Text(
                "Home",
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                currentWidget = News().obs;
                widget.closeDrawer();
                isChatOpen = true;
                if (mounted) setState(() {});
              },
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                currentWidget =
                    ChatScreen(userName: _displayname.toString()).obs;
                isChatOpen = false;
                if (mounted) {
                  setState(() {
                    widget.closeDrawer();
                  });
                }
              },
              leading: Icon(Icons.message_outlined),
              title: Text("Chat with support"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            // ListTile(
            //   onTap: () {
            //     showDialog<String>(
            //       context: context,
            //       builder: (BuildContext context) => AlertDialog(
            //         title: const Text('Coming Soon...'),
            //         content: Text(
            //           'Soon',
            //         ),
            //         actions: <Widget>[
            //           FlatButton(
            //             child: Text('Cancel'),
            //             onPressed: () => Navigator.pop(context, 'Cancel'),
            //           ),
            //           FlatButton(
            //             child: Text('OK'),
            //             onPressed: () => Navigator.pop(context, 'OK'),
            //           ),
            //         ],
            //       ),
            //     ).then((returnVal) {
            //       if (returnVal != null) {
            //         Scaffold.of(context).showSnackBar(
            //           SnackBar(
            //             backgroundColor: Colors.red,
            //             content: Text('You clicked: $returnVal'),
            //             action: SnackBarAction(
            //               label: 'OK',
            //               onPressed: () {},
            //               textColor: Colors.white,
            //               disabledTextColor: Colors.red,
            //             ),
            //           ),
            //         );
            //       }
            //     });
            //   },
            //   leading: Icon(Icons.settings),
            //   title: Text("Settings"),
            // ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                widget.closeDrawer();
                FirebaseAuth.instance.signOut();
                u_id = null;
                Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()))
                    .then((returnVal) {
                  if (returnVal != null) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('You are Signed out'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                          textColor: Colors.white,
                          disabledTextColor: Colors.red,
                        ),
                      ),
                    );
                  }
                });
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}

bool isChatOpen = true;

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  FSBStatus status;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SwipeDetector(
          onSwipeRight: () {
            setState(() {
              status = FSBStatus.FSB_OPEN;
            });
          },
          onSwipeLeft: () {
            setState(() {
              status = FSBStatus.FSB_CLOSE;
            });
          },
          child: Obx(() => FoldableSidebarBuilder(
              drawerBackgroundColor: Colors.redAccent,
              status: status,
              drawer: CustomDrawer(
                closeDrawer: () {
                  setState(() {
                    status = FSBStatus.FSB_CLOSE;
                  });
                },
              ),
              screenContents: currentWidget.value)),
        ),
        floatingActionButton: isChatOpen
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    status = status == FSBStatus.FSB_OPEN
                        ? FSBStatus.FSB_CLOSE
                        : FSBStatus.FSB_OPEN;
                  });
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              )
            : null,
      ),
    );
  }
}
//
//class SideBar0 extends StatefulWidget {
//  @override
//  _SideBar0State createState() => _SideBar0State();
//}
//
//class _SideBar0State extends State<SideBar0> {
//  FSBStatus status;
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        body: SwipeDetector(
//          onSwipeRight: () {
//            setState(() {
//              status = FSBStatus.FSB_OPEN;
//            });
//          },
//          onSwipeLeft: () {
//            setState(() {
//              status = FSBStatus.FSB_CLOSE;
//            });
//          },
//          child: FoldableSidebarBuilder(
//              drawerBackgroundColor: Colors.redAccent,
//              status: status,
//              drawer: CustomDrawer(
//                closeDrawer: () {
//                  setState(() {
//                    status = FSBStatus.FSB_CLOSE;
//                  });
//                },
//              ),
//              screenContents: Shop()),
//        ),
//        floatingActionButton: FloatingActionButton(
//          backgroundColor: Colors.white,
//          onPressed: () {
//            setState(() {
//              status = status == FSBStatus.FSB_OPEN
//                  ? FSBStatus.FSB_CLOSE
//                  : FSBStatus.FSB_OPEN;
//            });
//          },
//          child: Icon(
//            Icons.menu,
//            color: Colors.black,
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class SideBar01 extends StatefulWidget {
//  @override
//  _SideBar01State createState() => _SideBar01State();
//}
//
//class _SideBar01State extends State<SideBar01> {
//  FSBStatus status;
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        body: SwipeDetector(
//          onSwipeRight: () {
//            setState(() {
//              status = FSBStatus.FSB_OPEN;
//            });
//          },
//          onSwipeLeft: () {
//            setState(() {
//              status = FSBStatus.FSB_CLOSE;
//            });
//          },
//          child: FoldableSidebarBuilder(
//              drawerBackgroundColor: Colors.redAccent,
//              status: status,
//              drawer: CustomDrawer(
//                closeDrawer: () {
//                  setState(() {
//                    status = FSBStatus.FSB_CLOSE;
//                  });
//                },
//              ),
//              screenContents: Message()),
//        ),
//        floatingActionButton: FloatingActionButton(
//          backgroundColor: Colors.white,
//          onPressed: () {
//            setState(() {
//              status = status == FSBStatus.FSB_OPEN
//                  ? FSBStatus.FSB_CLOSE
//                  : FSBStatus.FSB_OPEN;
//            });
//          },
//          child: Icon(
//            Icons.menu,
//            color: Colors.black,
//          ),
//        ),
//      ),
//    );
//  }
//}
