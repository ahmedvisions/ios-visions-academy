
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'character.dart';
import 'style_guide_no_change.dart';

class CharacterDetailScreen extends StatefulWidget {

  final double _expandedBottomSheet = 0;
  final double _collapsedBottomSheet = -250;
  final double _fullCollapsedBottomSheet = -330;

  final Character0 character;

  const CharacterDetailScreen({Key key, this.character}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CharacterDetailScreenState();
  }
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> with AfterLayoutMixin<CharacterDetailScreen> {

  double _currentButtomSheet = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;


    // TODO: implement build
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "background-${widget.character.name}",
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: widget.character.colors,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft
                    )
                ),

              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 40,
                      color: Colors.white.withOpacity(0.9),
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 250) , () {
                          setState(() {
                            _currentButtomSheet = widget._fullCollapsedBottomSheet;
                          });
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Hero(
                        tag: "image-${widget.character.name}",
                        child: Image.asset(widget.character.imagePath,
                          height: screenHeight * 0.45,
                        ),
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                      child: Hero(
                          tag: "name-${widget.character.name}",
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                                child: Text(widget.character.name,
                                  style: AppTheme.heading,)
                            ),
                          )
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                    child: Text(
                      widget.character.description,
                      style: AppTheme.subHeading,),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.decelerate,
              bottom: _currentButtomSheet,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: _onTap,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        height: 60,
                        child: Text(
                          "Clips",
                          style: AppTheme.subHeading.copyWith(
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _clipsWidget(),
                    ),
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }

  _onTap(){
    setState(() {
      _currentButtomSheet = isCollapsed ? widget._expandedBottomSheet : widget._collapsedBottomSheet;
      isCollapsed = !isCollapsed;
    });
  }

  Widget _clipsWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
             Image.asset('assets/essay/Panther.png',height: 100,width: 100,semanticLabel: 'Hi broooo' ),
              SizedBox(height: 20,),
             Image.network('https://lh3.googleusercontent.com/proxy/96QLjl4IJQNqwj70orx26PO8-qLwZiir5hJvvXAHhm9Ox4NtEE2E1rqcW7c24Ithp5t_a7SWN8zf32rO2TgnvTg0hkFCz_fYpcLSiqXPU5AuGRT3',scale:5,),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[
              Image.asset('assets/essay/Panther.png',height: 100,width: 100,),
              SizedBox(height: 20,),
              Image.network('https://lh3.googleusercontent.com/proxy/96QLjl4IJQNqwj70orx26PO8-qLwZiir5hJvvXAHhm9Ox4NtEE2E1rqcW7c24Ithp5t_a7SWN8zf32rO2TgnvTg0hkFCz_fYpcLSiqXPU5AuGRT3',scale:5,),             //   return prgress == null ? child : LinearProgressIndicator();
           //   }),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[

              //data:image/jpeg;base64,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
         //    Image.asset('assets/essay/Panther.png',semanticLabel: 'Hi bro' ,height: 200,width: 200),
              SizedBox(height: 20,),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[
              Image.network('http://all-best.co/wp-content/uploads/2017/07/347-1.jpg',scale:6,),
              //   return prgress == null ? child : LinearProgressIndicator();
              SizedBox(height: 20,),
              roundedContainer(Colors.pinkAccent),
            ],
          ),
          SizedBox(width: 16,),
          Column(
            children: <Widget>[
              roundedContainer(Colors.deepOrange),
              SizedBox(height: 20,),
              roundedContainer(Colors.lightBlueAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isCollapsed = true;
        _currentButtomSheet = widget._collapsedBottomSheet;
      });
    });
  }
}
