import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/helpers/dialog_helper.dart';
import 'package:syriaonline/model/model%20rate.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/provider/providerData.dart';
import 'package:syriaonline/screen/page%20service%20info.dart';
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

  //----------------------------------------------------------------------------
  //---------------------------refearsh-----------------------------------------
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  // number that changes when refreshed

  ScrollController _scrollController;
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      _scaffoldKey.currentState;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ServiceInfo()));
    });
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
  bool result = false;
  addrate(context, Map map) async {
    result = await postdata(rate, map);
    print(map);
    result == false
        ? Fluttertoast.showToast(
            backgroundColor: Color(0xB7FF0000),
            msg: 'You cannot add a rating again because you did it before ',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM)
        : print("your rated now");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: Text(
            '        Details',
            textAlign: TextAlign.center,
            style: kTitleAppbarStyle,
          ),
          backgroundColor: kchooseColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          )),
      body: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 200,
        color: kchooseColor,
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: true,
        child: ListView(
          children: [
            Stack(children: [
              Container(
                color: kchooseColor,
                width: size.width,
                height: size.height - 82,
              ),
              Positioned(
                top: 75,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45)),
                  ),
                  width: size.width,
                  height: size.height - 100,
                ),
              ),
              //-------------------------image--------------------------------
              Positioned(
                top: 30,
                left: (size.width / 2) - 110,
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(service.picture),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 4,
                        blurRadius: 7,
                        color: Colors.black87.withOpacity(0.3),
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 270,
                left: 25,
                right: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //--------------------------name &phone-------------------------
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            service.serviceName,
                            style: kTexttitleDetails,
                          ),
                        ),
                        Expanded(
                          //---------------------stars rate-----------------------

                          child: Container(
                            margin: EdgeInsets.only(left: 26),
                            child: FutureBuilder<List<RateModel>>(
                              future: ratedata(),
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<List<RateModel>> snapshot) {
                                double sums = 0;
                                double result;
                                if (snapshot.data == null) {
                                  return Container();
                                } else {
                                  snapshot.data.forEach((element) {
                                    sums += double.parse(element.rateFrom5);
                                    result = sums / snapshot.data.length;
                                  });

                                  return SmoothStarRating(
                                      allowHalfRating: false,
                                      starCount: 5,
                                      rating: sums == 0 ? 0 : result,
                                      size: 25,
                                      isReadOnly: true,
                                      color: kColorStarsRated,
                                      borderColor: Colors.yellow,
                                      spacing: 0.0);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Phone  : +963${service.servicePhoneNumber}',
                            style: kTextBody,
                          ),
                        ),
                        //--------------------------add rate----------------------
                        Expanded(
                            child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            height: 50,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.grey.withOpacity(0.3),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Add Rate',
                                  style: kTextinfo,
                                ),
                                SmoothStarRating(
                                    allowHalfRating: false,
                                    starCount: 3,
                                    rating: 3,
                                    size: 15,
                                    isReadOnly: true,
                                    color: kColorStarsRated,
                                    borderColor: Colors.red,
                                    spacing: 0.0),
                              ],
                            ),
                          ),
                          onTap: () async {
                            return await DialogHelper.rate(context);
                          },
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //---------------------descrubtion-----------------------

                    Container(
                      height: 200,
                      width: size.width - 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        service.serviceDescription,
                        style: kTextdescrubt,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
