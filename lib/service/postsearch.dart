import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syriaonline/model/model%20sortService.dart';

Future<List<SortService>> searchdata(String pathapi, Map map) async {
  var url = Uri.parse(pathapi);
  List<SortService> servlist = [];

  var response = await http.post(url, body: map);
  if (response.statusCode == 200) {
    var resbody = jsonDecode(response.body);
    for (var item in resbody) {
      servlist.add(SortService.fromJson(item));
    }
    for (var item in servlist) {
      print(item.service.serviceName);
    }
    return servlist;
  } else {
    print("statuscode = ${response.statusCode}");
  }
}
