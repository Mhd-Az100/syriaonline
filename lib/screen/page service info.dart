import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
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
            Color(0xff233e8b),
            Color(0xFF3F5DAF),
            Color(0xFF72A5A7),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        items: [
          TabItemIcon(
            iconData: LineIcons.commentDots,
            curveColor: kCurveColorNAV,
            startColor: kStartColorNAV,
            endColor: kEndColorNAV,
          ),
          TabItemIcon(
              iconData: LineIcons.store,
              curveColor: kCurveColorNAV,
              startColor: kStartColorNAV,
              endColor: kEndColorNAV),
          TabItemIcon(
              buildWidget: (_, color) => Container(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    "img/icons/iconsearch.svg",
                    width: 40,
                  )),
              curveColor: kCurveColorNAV,
              startColor: kStartColorNAV,
              endColor: kEndColorNAV),
        ],
        selectedIndex: indexpage,
      ),
    );
  }
}
