import 'dart:async';

import '../model/model services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/utils/allUrl.dart';

class GetServiceApi {
  String n;
  GetServiceApi({this.n});
  Future<List<ServicesModel>> getserv(Map data) async {
    List<ServicesModel> servlist = [];
    print('n= ' + n);
    print('befor post data $data');

    var url = Uri.parse(sortservices + n);
    http.Response res = await http.post(url, body: data);
    print('after post data ${res.body}');

    // while (res.body == null) {
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
    //if (res.statusCode != 444) break;
    // }
  }
}
