import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/utils/allUrl.dart';

class GetCommentsApi {
  String id;
  GetCommentsApi({this.id});
  Future<List<CommentModel>> getRate() async {
    var url = Uri.parse(commentId + id);

    List<CommentModel> comlst = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        comlst.add(CommentModel.fromJson(item));
      }
      for (var item in comlst) {
        print(item.account.firstName);
      }

      return comlst;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }
}
