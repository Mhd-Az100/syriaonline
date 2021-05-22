import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/utils/allUrl.dart';
import 'package:syriaonline/model/model rate.dart';

class GetRate {
  String id;
  GetRate({this.id});
  Future<List<RateModel>> getRate() async {
    var url = Uri.parse(rateId + id);

    List<RateModel> comlst = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        comlst.add(RateModel.fromJson(item));
      }

      for (var item in comlst) {
        print('from rate api');

        print('${item.rateFrom5}');
      }

      return comlst;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
