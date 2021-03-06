import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/screen/Page%20AddService.dart';
import 'package:syriaonline/screen/page googlemap view all service.dart';

import '../screen/page category list.dart';
import '../screen/page choose.dart';
import '../screen/page login.dart';
import 'constent.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var firstname;
  var lastname;
  var pictureprofile;
  var email;
  var picture;
  bool isSign = false;
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    firstname = preferences.getString('first_name');
    lastname = preferences.getString('last_name');
    email = preferences.getString('e_mail');
    picture = preferences.getString('picture');

    if (firstname != null) {
      setState(() {
        firstname = preferences.getString('first_name');
        lastname = preferences.getString('last_name');
        email = preferences.getString('e_mail');
        picture = preferences.getString('picture');
        isSign = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getpref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: Scaffold(
        backgroundColor: kchooseColor,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0), bottomRight: Radius.circular(200)),
          ),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: isSign
                    ? Text(
                        firstname + " " + lastname,
                        style: kTextBody,
                      )
                    : Text(''),
                accountEmail: isSign
                    ? Text(
                        email,
                        style: kTextinfo,
                      )
                    : Text(''),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(
                      picture,
                    ),
                    backgroundColor: Colors.grey,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF93CFC0),
                      Color(0xFF9FBFC4),
                      Color(0xFFFFFFFF),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChoosePage(),
                      )),
                      child: ListTile(
                          title: Text(
                            'Home Page',
                            style: kTitledrawer,
                          ),
                          leading: SvgPicture.asset(
                            "img/icons/home.svg",
                            width: 30,
                          )),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryListPage(),
                      )),
                      child: ListTile(
                          title: Text(
                            'Browse Services',
                            style: kTitledrawer,
                          ),
                          leading: SvgPicture.asset(
                            "img/icons/view.svg",
                            width: 30,
                          )),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddService(),
                      )),
                      child: ListTile(
                          title: Text(
                            'Add Service',
                            style: kTitledrawer,
                          ),
                          leading: SvgPicture.asset(
                            "img/icons/add.svg",
                            width: 30,
                          )),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GooglemapsAll(),
                      )),
                      child: ListTile(
                          title: Text(
                            'All service maps',
                            style: kTitledrawer,
                          ),
                          leading: SvgPicture.asset(
                            "img/icons/map2.svg",
                            width: 30,
                          )),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.remove('first_name');
                        preferences.remove('last_name');
                        preferences.remove('e_mail');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      },
                      child: ListTile(
                        title: Text(
                          'Sign Out',
                          style: kTitledrawer,
                        ),
                        leading: SvgPicture.asset(
                          "img/icons/signout.svg",
                          width: 30,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            enableDrag: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: kchooseColor,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "img/icons/web-development.svg",
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'We are mobile developers studying software engineering in Syria, our team works in programming web and mobile applications ',
                                            style: kTextinfo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "img/icons/info.svg",
                              width: 50,
                            ),
                            Text(
                              'about us',
                              style: kTitledrawer,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
