import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:syriaonline/model/model%20account.dart';
import 'package:syriaonline/provider/providerData.dart';

Future<bool> loginpost(String pathapi, Map map, BuildContext context) async {
  var url = Uri.parse(pathapi);
  Account account;
  var res = await http.post(url, body: map);

  if (res.statusCode == 200) {
    var resbody = jsonDecode(res.body);

    savepref(resbody['first_name'], resbody['last_name'], resbody['e_mail'],
        resbody['account_id'], resbody['picture']);
    return true;
  } else {
    return false;
  }
}

//------------------shared preferences----------------------------------------
savepref(String firstName, String lastName, String email, int accountId,
    String picture) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('first_name', firstName);
  preferences.setString('last_name', lastName);
  preferences.setString('e_mail', email);
  preferences.setString('account_id', accountId.toString());
  preferences.setString('picture', picture.toString());

  // مشان اتاكد
  print(preferences.getString('first_name'));
  print(preferences.getString('last_name'));
  print(preferences.getString('e_mail'));
  print(preferences.getString('account_id'));
  print(preferences.getString('picture'));
}
