import 'package:flutter/material.dart';
import 'package:syriaonline/screen/page%20details.dart';
import '../constant/constent.dart';
import '../constant/drawer.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';
import 'page comment.dart';
import 'page googlemap.dart';

class ServiceInfo extends StatefulWidget {
  @override
  _ServiceInfoState createState() => _ServiceInfoState();
}

class _ServiceInfoState extends State<ServiceInfo> {
  List<Map<String, Object>> _pages = [
    {},
    //pagecomment/////////////////////////
    {
      'page': PageComment(),
      'title': Text(
        'Comment',
        style: kTitleAppbarStyle,
      )
    },
    //details/////////////////////////

    {
      'page': Detailes(),
      'title': Text(
        'Info Service',
        style: kTitleAppbarStyle,
      )
    },
    //google map/////////////////////////

    {
      'page': Googlemaps(),
      'title': Text(
        'Location Map',
        style: kTitleAppbarStyle,
      )
    },
  ];

  int indexpage = 2;
  void onchangetab(int index) {
    setState(() {
      indexpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: _pages[indexpage]['title'],
      ),
      drawer: MyDrawer(),
      body: _pages[indexpage]['page'],
      //----------------------------navigationbar-------------------------------

      bottomNavigationBar: JumpingTabBar(
        onChangeTab: onchangetab,
        backgroundColor: Color(0xFF005B72),
        circleGradient: LinearGradient(
          colors: [
            Colors.purpleAccent,
            Colors.deepPurple,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        items: [
          TabItemIcon(
              iconData: Icons.comment_rounded,
              curveColor: Colors.blue,
              startColor: Colors.yellow,
              endColor: Colors.blue),
          TabItemIcon(
              iconData: Icons.store_mall_directory_rounded,
              curveColor: Colors.orange,
              startColor: Colors.yellow,
              endColor: Colors.blue),
          TabItemIcon(
              iconData: Icons.location_on,
              curveColor: Colors.blue,
              startColor: Colors.yellow,
              endColor: Colors.blue),
        ],
        selectedIndex: indexpage,
      ),
    );
  }
}
