import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/model/model%20rate.dart';
import 'package:syriaonline/model/model%20services.dart';

class Providerdata extends ChangeNotifier {
  ServicesModel service;
  CategoryModel category;
  Map mapcurrentlocation;
  RateModel rate;
  void setService({@required ServicesModel val}) {
    service = val;
    notifyListeners();
  }

  void setcategory({@required CategoryModel val1}) {
    category = val1;
    notifyListeners();
  }

  void setcurrentlocation({@required Map val2}) {
    mapcurrentlocation = val2;
    notifyListeners();
  }

  void setrate({@required RateModel val3}) {
    rate = val3;
    notifyListeners();
  }
}
//---------write-------------

setService({@required context, @required ServicesModel val}) {
  Provider.of<Providerdata>(context, listen: false).setService(val: val);
}

setcategory({@required context, @required CategoryModel val1}) {
  Provider.of<Providerdata>(context, listen: false).setcategory(val1: val1);
}

setcurrentlocation({@required context, @required Map val2}) {
  Provider.of<Providerdata>(context, listen: false)
      .setcurrentlocation(val2: val2);
}

setrate({@required context, @required RateModel val3}) {
  Provider.of<Providerdata>(context, listen: false).setrate(val3: val3);
}

//---------read-------------

ServicesModel service(context) {
  ServicesModel serviceID =
      Provider.of<Providerdata>(context, listen: false).service;
  return serviceID;
}
