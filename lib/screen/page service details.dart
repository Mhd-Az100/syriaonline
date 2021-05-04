import 'package:flutter/material.dart';
import 'package:syriaonline/service/categoryApi.dart';
import '../constant/constent.dart';
import '../constant/drawer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';
import 'page comment.dart';
import 'page googlemap.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

double ratingX = 2.5;
int indexpage = 2;

class _DetailsState extends State<Details> {
  fdata() async {
    GetCategoryApi cat = GetCategoryApi();
    cat.getcateg();
  }

  void initState() {
    super.initState();
    fdata();
  }

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
      'page': Scaffold(
        body: ListView(
          children: [
            //details service/////////////////////////

            Container(
              height: 250,
              child: GridTile(
                child: Image.asset('img/S3.jpg'),
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text('name type servic '),
                    title: Row(
                      children: [
                        Expanded(child: Text('name service')),
                        Expanded(
                            child: SmoothStarRating(
                                allowHalfRating: false,
                                starCount: 5,
                                rating: 2.5, //from data
                                size: 20,
                                isReadOnly: true,
                                color: Colors.red,
                                borderColor: Colors.red,
                                spacing: 0.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
                child: Text(
              'Rate This Service ',
              style: kTextBody,
            )),
            SizedBox(
              height: 25,
            ),
            //stars rate/////////////////////////

            Center(
              child: SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {
                    ratingX = v;

                    //for data
                  },
                  starCount: 5,
                  rating: ratingX,
                  size: 40.0,
                  isReadOnly: false,
                  color: Colors.yellow,
                  borderColor: Colors.yellow,
                  spacing: 0.0),
            ),
            SizedBox(
              height: 25,
            ),
            //descrubtion/////////////////////////

            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'A restaurant or an eatery, is a business that prepares and serves food and drinks to customers. ... By 1723 there were nearly four hundred cafés in Paris, but their menu was limited to simpler dishes or confectionaries, such as coffee, tea',
                  style: kTextBody,
                ),
              ),
            ),
          ],
        ),
      ),
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
  //method rate stars/////////////////////////

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
      //navigationbar/////////////////////////

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
