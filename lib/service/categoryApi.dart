import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/utils/allUrl.dart';

class GetCategoryApi {
  var url = Uri.parse(servicescatogary);
  Future<List<CategoryModel>> getcateg() async {
    List<CategoryModel> catlist = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        catlist.add(CategoryModel.fromJson(item));
      }

      return catlist;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
