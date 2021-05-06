import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syriaonline/model/model%20comment.dart';
import 'package:syriaonline/utils/allUrl.dart';

class CommentsApi {
  var url = Uri.parse(rate);
  Future<List<RateModel>> getcomment() async {
    List<RateModel> comlst = [];

    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (var item in body) {
        comlst.add(RateModel.fromJson(item));
      }
      for (var item in comlst) {
        print(item.comment);
      }

      return comlst;
    } else {
      print('statuscode=${res.statusCode}');
    }
  }

  // Future<CommentModel> addComment({Map comment}) async {
  //   var url = Uri.parse(rate);
  //   var response = await http.post(
  //     url,
  //     body: jsonEncode(comment),
  //   );
  //   if (response.statusCode == 201) {
  //     var responseBody = jsonDecode(response.body);
  //     CommentModel comm = CommentModel.fromJson(responseBody);
  //     return comm;
  //   } else {
  //     return null;
  //   }
  // }
}
