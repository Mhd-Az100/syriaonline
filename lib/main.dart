import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/screen/pagesignUp.dart';
import 'screen/page choose.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var firstname = preferences.getString('first_name');
  var lastname = preferences.getString('last_name');

  runApp(firstname != null && lastname != null ? Home() : Sign());
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChoosePage(),
    );
  }
}

class Sign extends StatefulWidget {
  @override
  SignState createState() => SignState();
}

class SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUP(),
    );
  }
}
