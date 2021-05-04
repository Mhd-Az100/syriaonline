import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/utils/allUrl.dart';

class GetCommentsApi {
  var url = Uri.parse(rate);
  Future<List<CommentModel>> getcomment() async {
    List<CommentModel> comlst = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        comlst.add(CommentModel.fromJson(item));
      }
      for (var i in comlst) {
        print(i.comment);
        // print(i.accountId);
      }

      return comlst;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
