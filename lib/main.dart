import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/service/postemail.dart';
import 'package:syriaonline/splashsrcreen/tap.dart';
import 'package:syriaonline/utils/allUrl.dart';
import 'screen/page choose.dart';
import 'provider/providerData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var email;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email = preferences.getString('e_mail');
  if (email != null) {
    Map m = {'email': email.toString()};
    bool t = await senddata(m);
    if (t) {
      runApp(Home());
    } else {
      preferences.remove('e_mail');
      runApp(Sign());
    }
  } else {
    runApp(Sign());
  }
}

senddata(Map map) async {
  bool result1 = await postemail(cheackifemailexict, map);
  return result1;
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
    return ChangeNotifierProvider(
      create: (context) => Providerdata(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SimplePageSelector(),
      ),
    );
  }
}
