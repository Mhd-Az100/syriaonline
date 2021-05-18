import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/screen/page%20comment.dart';
import 'package:syriaonline/screen/page%20signUp.dart';
import 'screen/page choose.dart';
import 'provider/providerData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var firstname = preferences.getString('first_name');
  var lastname = preferences.getString('last_name');

  runApp(firstname != null && lastname != null ? Home() : Sign());
  // runApp(Test());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Providerdata(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChoosePage(),
      ),
    );
  }
}

class Sign extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUP(),
    );
  }
}

class Test extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageComment(),
    );
  }
}
