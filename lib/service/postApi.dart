import 'package:http/http.dart' as http;

Future<bool> postdata(String pathapi, Map map) async {
  var url = Uri.parse(pathapi);

  var response = await http.post(url, body: map);
  if (response.statusCode == 201) {
    return true;
  } else {
    print("statuscode = ${response.statusCode}");
    return false;
  }
}
