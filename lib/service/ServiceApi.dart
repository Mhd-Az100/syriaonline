import '../model/model services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/utils/allUrl.dart';

class GetServiceApi {
  final String id;
  final String categoryName;
  GetServiceApi({this.id, this.categoryName});
  var url = Uri.parse(catogarytype+'2');

  Future<List<ServicesModel>> getserv() async {
    List<ServicesModel> servlist = [];

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
