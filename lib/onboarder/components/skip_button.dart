
import 'package:flutter/material.dart';
import 'package:visions_academy/onboarder/config/size_config.dart';
import 'package:visions_academy/onboarder/constants/color.dart';
import 'package:visions_academy/ui/screens/login_signup/sign_up/signup_screen.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const SignupScreen()));
            },
            child: Text(
              'Skip',
              style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.4, //14
                  color: kDefaultAppColor,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
