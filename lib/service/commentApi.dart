import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/utils/allUrl.dart';

class CommentsApi {
  CommentsApi();
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

  Future<CommentModel> addComment({Map comment}) async {
    var url = Uri.parse(rate);
    var response = await http.post(
      url,
      body: jsonEncode(comment),
    );
    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      CommentModel comm = CommentModel.fromJson(responseBody);
      return comm;
    } else {
      return null;
    }
  }
}
