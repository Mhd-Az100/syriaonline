import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/utils/allUrl.dart';

class GetCommentsApi {
  GetCommentsApi();
  var url = Uri.parse(rate);
  Future<List<CommentModel>> getcomment() async {
    List<CommentModel> comlst = [];

    http.Response res = await http.post(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        comlst.add(CommentModel.fromJson(item));
      }

      return comlst;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
