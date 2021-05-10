import '../model/model services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/utils/allUrl.dart';

class GetInfo {
  String n;
  GetInfo({this.n});
  Future<ServicesModel> getserv() async {
    print(n);
    ServicesModel servinfo;
    var url = Uri.parse(services + '/1');
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      servinfo = ServicesModel.fromJson(body);

      return servinfo;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
