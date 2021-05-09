import 'package:syriaonline/screen/page%20category%20view.dart';

import '../model/model services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/utils/allUrl.dart';

class GetServiceApi {
  String n;
  GetServiceApi({this.n});
  Future<List<ServicesModel>> getserv() async {
    print(n);
    List<ServicesModel> servlist = [];
    var url = Uri.parse(catogarytype + n);
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        servlist.add(ServicesModel.fromJson(item));
      }
      for (var item in servlist) {
        print(item.serviceName);
      }

      return servlist;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
