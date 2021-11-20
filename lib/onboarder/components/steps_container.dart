
import 'package:flutter/material.dart';
import 'package:visions_academy/onboarder/config/size_config.dart';
import 'package:visions_academy/onboarder/constants/color.dart';
import 'package:visions_academy/onboarder/model/slide.dart';


class StepsContainer extends StatelessWidget {
  const StepsContainer(
      {Key key,
      @required this.page,
      @required List<Slide> list,
      @required PageController controller,
      @required this.showAnimatedContainerCallBack})
      : _list = list,
        _controller = controller,
        super(key: key);

  final int page;
  final List<Slide> _list;
  final PageController _controller;
  final Function showAnimatedContainerCallBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.defaultSize * 4.5,
      height: SizeConfig.defaultSize * 4.5,
      child: Stack(
        children: [
          Container(
            width: SizeConfig.defaultSize * 4.5,
            height: SizeConfig.defaultSize * 4.5,
            child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(kDefaultAppColor),
                value: (page + 1) / (_list.length + 1)),
          ),
          Center(
            child: InkWell(
              onTap: () {
                if (page < _list.length && page != _list.length - 1) {
                  _controller.animateToPage(page + 1,
                      duration: Duration(microseconds: 500),
                      curve: Curves.easeInCirc);
                  showAnimatedContainerCallBack(false);
                } else {
                  //TODO:- show animated Container
                  showAnimatedContainerCallBack(true);
                }
              },
              child: Container(
                width: SizeConfig.defaultSize * 3.5,
                height: SizeConfig.defaultSize * 3.5,
                decoration: const BoxDecoration(
                    color: kDefaultAppColor,
                    borderRadius: BorderRadius.all(Radius.circular(100.0))),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
