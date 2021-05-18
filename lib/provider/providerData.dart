import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providerdata extends ChangeNotifier {
  String serviceID = '';

  void setServiceID({@required String val}) {
    serviceID = val;
    notifyListeners();
  }
}
//---------write-------------

setServiceID({@required context, @required String val}) {
  Provider.of<Providerdata>(context, listen: false).setServiceID(val: val);
}

//---------read-------------

String serviceID(context) {
  String serviceID =
      Provider.of<Providerdata>(context, listen: false).serviceID;
  return serviceID;
}
