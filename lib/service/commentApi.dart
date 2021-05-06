import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/utils/allUrl.dart';

class CommentsApi {
  var url = Uri.parse(rate);
  Future<List<RateModel>> getRate() async {
    List<RateModel> comlst = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        comlst.add(RateModel.fromJson(item));
      }

      return comlst;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
