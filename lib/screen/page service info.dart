import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syriaonline/screen/page%20details3.dart';
import '../constant/constent.dart';
import '../constant/drawer.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';
import 'page comment.dart';
import 'page googlemap view.dart';

class ServiceInfo extends StatefulWidget {
  @override
  _ServiceInfoState createState() => _ServiceInfoState();
}

class _ServiceInfoState extends State<ServiceInfo> {
  @override
  void initState() {
    super.initState();
  }

  List<Map<String, Object>> _pages = [
    {},
    //--------------------------------pagecomment-------------------------------
    {
      'page': PageComment(),
    },
    //----------------------------------details---------------------------------

    {
      'page': Detailes(),
    },
    //-----------------------------google map-----------------------------------
    {
      'page': Googlemaps(),
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
      drawer: MyDrawer(),
      body: _pages[indexpage]['page'],
      //----------------------------navigationbar-------------------------------

      bottomNavigationBar: JumpingTabBar(
        onChangeTab: onchangetab,
        backgroundColor: kchooseColor,
        circleGradient: LinearGradient(
          colors: [
            Color(0xFFBCF0FD),
            Color(0xFFC4C4C4),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        items: [
          TabItemIcon(
            buildWidget: (_, color) => Container(
              width: 36,
              height: 36,
              child: SvgPicture.asset(
                "img/icons/comments.svg",
                width: 40,
              ),
            ),
            curveColor: Colors.grey[50],
            startColor: kStartColorNAV,
            endColor: kEndColorNAV,
          ),
          TabItemIcon(
              buildWidget: (_, color) => Container(
                    width: 36,
                    height: 36,
                    child: SvgPicture.asset(
                      "img/icons/store.svg",
                      width: 40,
                    ),
                  ),
              curveColor: kCurveColorNAV,
              startColor: kStartColorNAV,
              endColor: kEndColorNAV),
          TabItemIcon(
              buildWidget: (_, color) => Container(
                    width: 36,
                    height: 36,
                    child: SvgPicture.asset(
                      "img/icons/map.svg",
                      width: 40,
                    ),
                  ),
              curveColor: Colors.lightGreen[400],
              startColor: kStartColorNAV,
              endColor: kEndColorNAV),
        ],
        selectedIndex: indexpage,
      ),
    );
  }
}
