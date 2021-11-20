import 'package:flutter/material.dart';
import 'package:visions_academy/onboarder/animations/fade_animation.dart';
import 'package:visions_academy/onboarder/config/size_config.dart';
import 'package:visions_academy/onboarder/constants/color.dart';
import 'package:visions_academy/onboarder/model/slide.dart';



class MainContent extends StatelessWidget {
  const MainContent(
      {Key key, @required List<Slide> list, @required this.index})
      : _list = list,
        super(key: key);

  final List<Slide> _list;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: FadeAnimation(
              0.5,
              Image.asset(
                _list[index].imageUrl,
                height: SizeConfig.defaultSize * 30,
                width: SizeConfig.defaultSize * 30,
              ),
            ),
          ),
          FadeAnimation(
            0.9,
            Text(
              _list[index].title,
              style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.defaultSize * 2.6),
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize,
          ),
          FadeAnimation(
            1.1,
            Text(
              _list[index].description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kLightGreyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.defaultSize * 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
