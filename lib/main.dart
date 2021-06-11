import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/screen/page%20signUp.dart';
import 'package:syriaonline/service/postemail.dart';
import 'package:syriaonline/utils/allUrl.dart';
import 'screen/page choose.dart';
import 'provider/providerData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var email;

  SharedPreferences preferences = await SharedPreferences.getInstance();
  email = preferences.getString('e_mail');

  runApp(email != null ? Home() : Sign());
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
