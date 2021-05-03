import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/page%20categorylist.dart';

import '../screen/page add Service.dart';
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

  var email;

  bool isSign = false;
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    firstname = preferences.getString('first_name');
    lastname = preferences.getString('last_name');
    email = preferences.getString('e_mail');
    if (firstname != null) {
      setState(() {
        firstname = preferences.getString('first_name');
        lastname = preferences.getString('last_name');
        email = preferences.getString('e_mail');
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
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: isSign ? Text(firstname + " " + lastname) : Text(''),
            accountEmail: isSign ? Text(email) : Text(''),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: kColorbackCircleAvatar,
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: kBackCardColordrawer,
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChoosePage(),
            )),
            child: ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home_rounded),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddService(),
            )),
            child: ListTile(
              title: Text('Add Service'),
              leading: Icon(Icons.post_add_rounded),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryListPage(),
            )),
            child: ListTile(
              title: Text('View Services'),
              leading: Icon(Icons.view_carousel_rounded),
            ),
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
              title: Text('Sign Out'),
              leading: Icon(
                Icons.logout,
              ),
            ),
          )
        ],
      ),
    );
  }
}
