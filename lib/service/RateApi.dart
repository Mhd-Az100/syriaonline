import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/utils/allUrl.dart';
import 'package:syriaonline/model/model rate.dart';

class GetRate {
  String id;
  GetRate({this.id});
  Future<List<RateModel>> getRate() async {
    var url = Uri.parse(rateId + id);

    List<RateModel> rates = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        rates.add(RateModel.fromJson(item));
      }
      print('befor for print ');

      for (var i in rates) {
        print('from rate api');

        print(i.rateFrom5);
      }

      return rates;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
