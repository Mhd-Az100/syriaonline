import 'package:flutter/material.dart';
import '../model/model services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/utils/allUrl.dart';

class GetServiceApi {
  GetServiceApi(
    this.id,
  );
  final int id;
  var url = Uri.parse(services);

  Future<List<ServicesModel>> getserv() async {
    List<ServicesModel> servlist = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        servlist.add(ServicesModel.fromJson(item));
      }
      for (var i in servlist) {
        print(i.serviceName);
      }

      return servlist;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
