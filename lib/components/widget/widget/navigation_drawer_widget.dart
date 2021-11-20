import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visions_academy/ui/screens/chat/chat_screen.dart';
import 'package:visions_academy/ui/screens/home_screen/home_and_Screen/home_page.dart';
import 'package:visions_academy/ui/screens/home_screen/home_screen.dart';
import 'package:visions_academy/ui/screens/information/information0.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/database.dart';
import 'package:visions_academy/ui/screens/login_signup/login/login_screen.dart';
import 'package:visions_academy/ui/screens/login_signup/splach_screen/on_boarding.dart';
import 'package:visions_academy/ui/screens/notfaction_screen/notfaction.dart';
import 'package:visions_academy/ui/screens/profile_screen/profile.dart';


import '../../../constants.dart';

Rx<Widget> currentWidget = const HomeScreen(
  username: "Visions Academy",
).obs;

class NavigationDrawerWidget extends StatefulWidget {
  final Function closeDrawer;

  const NavigationDrawerWidget({Key key, this.closeDrawer}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 10);
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
    final data = userSS.data() as Map<String, dynamic>;
    if (mounted) {
      setState(() {
        // _displayname =
        //     FirebaseFirestore.instance.collection("displayName").toString();
        // _email = FirebaseFirestore.instance.collection("email").toString();
        // _displayname = userSS.data()["displayName"];
        // _email = userSS.data()["email"];
        _displayname=data["displayName"];
        _email=data["email"];
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
             Container(
               color: Colors.white,
               child: UserAccountsDrawerHeader(
                accountName: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(_displayname,
                      style: const TextStyle(
                          color: Colors.lightBlueAccent,
                          fontStyle: FontStyle.italic,
                          fontSize: 18)),
                ),
                accountEmail: Text("$_email",
                    style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontStyle: FontStyle.italic,
                        fontSize: 14)
                ),
                decoration:  const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(
                      'assets/images/education.jpg',
                    ),
                  ),
                ),
            //   Text("$_email",
            //       style: const TextStyle(
            //           color: Colors.black,
            //           fontStyle: FontStyle.italic,
            //           fontSize: 14)),
            ),
             ),

            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'ChatSupport',
                    icon: Icons.chat,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const Divider(color: Colors.white70),
                  buildMenuItem(
                    text: 'About App',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context,3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'LogOut',
                    icon: Icons.logout,
                    onClicked:() {
              signout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


void signout(){

  FirebaseAuth.instance.signOut();
  u_id = null;
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) =>const OnBoardingSlide()))
      .then((returnVal) {
    if (returnVal != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text('You are Signed out'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
            textColor: Colors.white,
            disabledTextColor: Colors.blue,
          ),
        ),
      );
    }
  });
}
  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ScreenVideo1()));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                   NotfactionScreen()));
        break;
    }
  }
}
