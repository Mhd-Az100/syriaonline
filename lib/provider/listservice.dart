import 'package:flutter/cupertino.dart';
import 'package:syriaonline/model/model%20sortService.dart';
import 'package:syriaonline/service/ServiceApi.dart';
import 'package:provider/provider.dart';

class ServicesProvider extends ChangeNotifier {
  List<SortService> servcies;

  fetchData(id, location) async {
    print("fdATA");
    GetServiceApi type = GetServiceApi(n: id.toString());
    List<SortService> types = await type.getserv(location);
    servcies = types;
    notifyListeners();
  }
}
