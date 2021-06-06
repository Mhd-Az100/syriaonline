import 'dart:async';

import 'package:syriaonline/model/model%20sortService.dart';

import '../model/model services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/utils/allUrl.dart';

class GetServiceApi {
  String n;
  GetServiceApi({this.n});
  Future<List<SortService>> getserv(Map data) async {
    List<SortService> servlist = [];
    print('n= ' + n);
    print('befor post data $data');

    var url = Uri.parse(sortservices + n);
    http.Response res = await http.post(url, body: data);

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        servlist.add(SortService.fromJson(item));
      }
      for (var item in servlist) {
        print(item.service.serviceName);
      }

      return servlist;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }

  Future<List<SortService>> getSearchServ(Map data) async {
    List<SortService> servlist = [];
    print('n= ' + n);
    print('befor post data $data');

    var url = Uri.parse(searchonservice + n);
    http.Response res = await http.post(url, body: data);

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        servlist.add(SortService.fromJson(item));
      }
      for (var item in servlist) {
        print(item.service.serviceName);
      }

      return servlist;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
