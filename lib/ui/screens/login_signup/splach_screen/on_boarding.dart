import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visions_academy/components/component.dart';
import 'package:visions_academy/components/shard/shard.dart';
import 'package:visions_academy/ui/screens/home_screen/home_screen.dart';
import 'package:visions_academy/ui/screens/login_signup/login/login_screen.dart';
import 'package:visions_academy/ui/screens/login_signup/model/slide.dart';
import 'package:visions_academy/ui/screens/login_signup/sign_up/signup_screen.dart';
import 'package:visions_academy/ui/screens/login_signup/style/login_slide/slide_dots.dart';
import 'package:visions_academy/ui/screens/login_signup/style/login_slide/slide_item.dart';



class OnBoardingSlide extends StatefulWidget {

  const OnBoardingSlide({Key key}) : super(key: key);

  @override
  _OnBoardingSlideState createState() => _OnBoardingSlideState();
}

class _OnBoardingSlideState extends State<OnBoardingSlide> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: slideList.length,
                    itemBuilder: (ctx, i) => SlideItem(i),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 35),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for(int i = 0; i<slideList.length; i++)
                              if( i == _currentPage )
                                SlideDots(true)
                              else
                                SlideDots(false)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    child: const Text(
                      'Getting Started',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(15),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      storeOnboardInfo();
                      // Navigator.of(context).pushNamed(SignupScreen.routeName);
                      //  Navigator.pushReplacementNamed(context, "/register");
                      navigateTo(context, const SignupScreen());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Have an account?',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      FlatButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, "/log");
                          // Navigator.of(context).pushNamed(LoginScreen.routeName);
                          navigateTo(context,LoginScreen());
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
