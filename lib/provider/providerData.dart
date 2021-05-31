import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syriaonline/model/model%20services.dart';

class Providerdata extends ChangeNotifier {
  ServicesModel service;
  Map mapcurrentlocation;

  void setService({@required ServicesModel val}) {
    service = val;
    notifyListeners();
  }

  void setcurrentlocation({@required Map val2}) {
    mapcurrentlocation = val2;
    notifyListeners();
  }
}
//---------write-------------

setService({@required context, @required ServicesModel val}) {
  Provider.of<Providerdata>(context, listen: false).setService(val: val);
}

setcurrentlocation({@required context, @required Map val2}) {
  Provider.of<Providerdata>(context, listen: false)
      .setcurrentlocation(val2: val2);
}

//---------read-------------

ServicesModel service(context) {
  ServicesModel serviceID =
      Provider.of<Providerdata>(context, listen: false).service;
  return serviceID;
}

ServicesModel currentlocation(context) {
  ServicesModel serviceID =
      Provider.of<Providerdata>(context, listen: false).service;
  return serviceID;
}
