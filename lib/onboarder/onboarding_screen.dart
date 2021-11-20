import 'package:flutter/material.dart';
import 'package:visions_academy/ui/screens/login_signup/sign_up/signup_screen.dart';
import 'components/main_content.dart';
import 'components/skip_button.dart';
import 'components/steps_container.dart';
import 'config/size_config.dart';
import 'model/slide.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

   List<Slide> _list = Slide.list;

  int page = 0;
  var _controller = PageController();
  var showAnimatedContainer = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    _controller.addListener(() {
      setState(() {
        page = _controller.page.round();
      });
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            if (showAnimatedContainer) const Center(
                    child:SignupScreen(),
                  ) else SafeArea(
                    child: Column(
                      children: [
                        SkipButton(),
                        Expanded(
                          child: PageView.builder(
                              controller: _controller,
                              itemCount: _list.length,
                              itemBuilder: (context, index) => MainContent(
                                    list: _list,
                                    index: index,
                                  )),
                        ),
                        StepsContainer(
                          page: page,
                          list: _list,
                          controller: _controller,
                          showAnimatedContainerCallBack: (value) {
                            setState(() {
                              showAnimatedContainer = value;
                              if (value) {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                             const SignupScreen()));
                                });
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 4,
                        )
                      ],
                    ),
                  ),
          ],
        ));
  }
}
