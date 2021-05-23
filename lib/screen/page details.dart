import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/model/model%20rate.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/provider/providerData.dart';
import 'package:syriaonline/service/RateApi.dart';
import 'package:syriaonline/service/postApi.dart';
import 'package:syriaonline/utils/allUrl.dart';

class Detailes extends StatefulWidget {
  // Detailes({this.service});
  // int id;
  @override
  _DetailesState createState() => _DetailesState();
}

class _DetailesState extends State<Detailes> {
  ServicesModel service;
  String id;
  double ratingX = 0;

  void initState() {
    super.initState();
    service = Provider.of<Providerdata>(context, listen: false).service;
    id = Provider.of<Providerdata>(context, listen: false)
        .service
        .serviceId
        .toString();
    getpref();
    ratedata();
  }

//-------------------------------------get rate---------------------------------
  double sumrate;
  List<RateModel> ratees = [];
  Future<List<RateModel>> ratedata() async {
    GetRate rat = GetRate(id: id);

    List<RateModel> rates = await rat.getRate();
    ratees = rates;

    return ratees;
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

  addrate(context, Map map) async {
    bool result = await postdata(rate, map);
    print(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              //--------------------details service---------------------------------

              Container(
                height: 220,
                child: GridTile(
                  child: Image.network(service.picture),
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(flex: 2, child: Text(service.serviceName)),
                          Expanded(
                            child: FutureBuilder<List<RateModel>>(
                              future: ratedata(),
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<List<RateModel>> snapshot) {
                                double sums = 0;

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else {
                                  snapshot.data.forEach((element) {
                                    sums += double.parse(element.rateFrom5);
                                  });

                                  print("Obada thi is SUM : " +
                                      (sums / snapshot.data.length).toString());
                                  double result = sums / snapshot.data.length;

                                  return SmoothStarRating(
                                      allowHalfRating: false,
                                      starCount: 5,
                                      rating: result,
                                      size: 20,
                                      isReadOnly: true,
                                      color: kColorStarsRated,
                                      borderColor: Colors.red,
                                      spacing: 0.0);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Text(
                  'Phone Number : ${service.servicePhoneNumber}',
                  style: kTextBody,
                ),
              ),
              Center(
                  child: ratingX == 0
                      ? Text(
                          'Rate This Service ',
                          style: kTextBody,
                        )
                      : Container()),
              SizedBox(
                height: 25,
              ),
              //-------------------------------stars rate--------------------------

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ratingX == 0
                        ? SmoothStarRating(
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
                            spacing: 0.0)
                        : Container(),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ratingX == 0
                      ? IconButton(
                          icon: Icon(
                            Icons.check,
                            color: kiconColor,
                            size: 35,
                          ),
                          onPressed: () {
                            if (ratingX == 0) {
                              Fluttertoast.showToast(
                                  backgroundColor: kToastColor,
                                  textColor: kToastTextColor,
                                  msg: 'Add Rate Please',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM);
                              print("mhmd" + ratingX.toString());
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
                          })
                      : Container()
                ],
              ),
              SizedBox(
                height: 25,
              ),
              //-----------------------------descrubtion------------------------

              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    service.serviceDescription,
                    style: kTextBody,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      //     }
      //   },
      // ),
    );
  }
}

class StarsRate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
        allowHalfRating: false,
        starCount: 5,
        rating: 2.5,
        size: 20,
        isReadOnly: true,
        color: kColorStarsRated,
        borderColor: Colors.red,
        spacing: 0.0);
  }
}
