import 'package:flutter_svg/flutter_svg.dart';

import 'Page AddService.dart';
import 'page category list.dart';
import '../constant/constent.dart';
import 'package:flutter/material.dart';
import '../constant/drawer.dart';

class ChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: Icon(Icons.ac_unit_outlined),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kchooseColor,
        title: Text(
          'Home Page',
          style: kTitleAppbarStyle,
        ),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.4,
            decoration: BoxDecoration(
              color: kchooseColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //-------------------------------------view service card--------
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(),
                    ),
                  ),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: Offset(-6, 6),
                            color: Colors.white.withOpacity(.5),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        color: kCardHomeColor),
                    margin: EdgeInsets.all(50),
                    child: Center(
                        child: Text('Veiw Service', style: kTitleCardViewText)),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.4,
                color: kchooseColor,
                child: Column(),
              ),
              //-------------------------------------add service card---------
              Container(
                width: double.infinity,
                height: size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(80)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddService(),
                        ),
                      ),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(80),
                              topLeft: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(6, -6),
                                color: kchooseColor.withOpacity(.5),
                              )
                            ],
                            color: kchooseColor),
                        margin: EdgeInsets.all(50),
                        child: Center(
                            child:
                                Text('Add Service', style: kTitleCardAddText)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
