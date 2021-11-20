
import 'package:flutter/material.dart';
import 'character.dart';
import 'character_list_screen.dart';
import 'style_guide_no_change.dart';
/// list for all
class CharactersListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CharactersListScreenState();
  }
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 1.0,
        initialPage: currentPage,
        keepPage: false
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(

          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 8),
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Essays", style: AppTheme.display1),
                          TextSpan(text: "\n"),
                        //  TextSpan(text: "vitamin", style: AppTheme.display2),
                        ]
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      children:<Widget>[
                        for(var i = 0; i < characters.length; i++)
                          CharacterWidget(character: characters[i],pageController: _pageController, currentPage: i )
                      ]
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}