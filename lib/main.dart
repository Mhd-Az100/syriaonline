import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/screen/page%20comment.dart';
import 'package:syriaonline/screen/page%20signUp.dart';
import 'screen/page choose.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var firstname = preferences.getString('first_name');
  var lastname = preferences.getString('last_name');

  // runApp(firstname != null && lastname != null ? Home() : Sign());
  runApp(Test());
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

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageComment(),
    );
  }
}
