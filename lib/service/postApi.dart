import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> postdata(String pathapi, Map map) async {
  var url = Uri.parse(pathapi);

  var response = await http.post(url, body: map);

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}
