import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:syriaonline/constant/constent.dart';

import 'package:syriaonline/provider/providerData.dart';
import 'package:syriaonline/service/postApi.dart';
import 'package:syriaonline/utils/allUrl.dart';

class RateDialog extends StatefulWidget {
  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  String id;
  double ratingX = 0;

  void initState() {
    super.initState();
    id = Provider.of<Providerdata>(context, listen: false)
        .service
        .serviceId
        .toString();

    getpref();
  }

//-------------------------------------get id user------------------------------
  var iduser;

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      iduser = preferences.getString('account_id');
    });
  }

//-------------------------------------add rate----------------------------
  bool result = false;
  addrate(context, Map map) async {
    result = await postdata(rate, map);
    print(map);
    result == false
        ? Fluttertoast.showToast(
            backgroundColor: Color(0xB7FF0000),
            msg: 'You cannot send ',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM)
        : print("your rated now");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 350,
        decoration: BoxDecoration(
            color: kchooseColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                child: SmoothStarRating(
                    allowHalfRating: false,
                    onRated: (v) {
                      ratingX = v;

                      //for data
                    },
                    starCount: 5,
                    rating: ratingX,
                    size: 40.0,
                    isReadOnly: false,
                    color: kColorStarsRate,
                    borderColor: kColorStarsRate,
                    spacing: 0.0),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Rate the Service',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Text(
                'If you have already evaluated, your review will not be sent !',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Deny'),
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                RaisedButton(
                  onPressed: () {
                    if (ratingX == 0) {
                      Fluttertoast.showToast(
                          backgroundColor: kToastColor,
                          textColor: kToastTextColor,
                          msg: 'Add Rate Please',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);
                      return;
                    } else {
                      Map rated = {
                        'rate_from_5': '$ratingX',
                        'service_id': id.toString(),
                        'account_id': iduser.toString(),
                      };
                      print(rated);
                      setState(() {
                        addrate(context, rated);
                      });
                    }
                    return Navigator.of(context).pop(true);
                  },
                  child: Text('OK'),
                  color: Colors.white,
                  textColor: kchooseColor,
                )
              ],
            )
          ],
        ),
      );
}
