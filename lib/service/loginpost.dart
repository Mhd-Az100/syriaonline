import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/model/model%20account.dart';

Future<bool> loginpost(String pathapi, Map map) async {
  var url = Uri.parse(pathapi);
  Account account;
  var response = await http.post(url, body: map);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
