import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syriaonline/model/model%20services.dart';

class Providerdata extends ChangeNotifier {
  ServicesModel service;

  void setService({@required ServicesModel val}) {
    service = val;
    notifyListeners();
  }
}
//---------write-------------

setService({@required context, @required ServicesModel val}) {
  Provider.of<Providerdata>(context, listen: false).setService(val: val);
}

//---------read-------------

ServicesModel service(context) {
  ServicesModel serviceID =
      Provider.of<Providerdata>(context, listen: false).service;
  return serviceID;
}
