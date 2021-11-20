import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:visions_academy/components/widget/widget/silver_app_bar.dart';
import 'package:visions_academy/ui/screens/organic_test/chapter_one_oganic_video.dart';
import 'package:visions_academy/ui/videos_gallery/sliver_persistent_header_delegate.dart';


class ScreenVideo1 extends StatefulWidget {
  const ScreenVideo1({Key key, this.courseName, this.chaptNo}) : super(key: key);
  final String courseName;
  final int chaptNo;
  @override
  _ScreenVideo1State createState() => _ScreenVideo1State();
}

class _ScreenVideo1State extends State<ScreenVideo1>
    with SingleTickerProviderStateMixin {
  List<Tuple3> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      // Tuple3(
      //     'Tutorials',
      //     UpVid2(
      //       chapt: widget.chaptNo,
      //       coursename: widget.courseName,
      //     ),
      //     Icon(Icons.video_library)),
      const Tuple3('Tutorials', ChapterOneOrganic(), Icon(Icons.image)),
    ];
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              PortfolioSliverAppBar(_pages[_tabController.index].item1),
              SliverPersistentHeader(
                delegate: SliverPersistentHeaderDelegateImpl(
                  tabBar: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    controller: _tabController,
                    tabs: _pages
                        .map<Tab>((Tuple3 page) => Tab(text: page.item1))
                        .toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: _pages.map<Widget>((Tuple3 page) => page.item2).toList(),
          ),
        ),
        // bottomNavigationBar: Container(
        //   color: Colors.blue,
        //   child: TabBar(
        //     unselectedLabelColor: Colors.grey,
        //     labelColor: Colors.black,
        //     indicatorColor: Colors.black,
        //     controller: _tabController,
        //     tabs: _pages
        //         .map<Tab>((Tuple3 page) => Tab(
        //               text: page.item1,
        //               icon: page.item3,
        //             ))
        //         .toList(),
        //   ),
        // ),
      ),
    );
  }
}
