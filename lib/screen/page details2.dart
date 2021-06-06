import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: kdetailsbodyColor,
      appBar: AppBar(
          elevation: 0,
          title: Text(
            '        Details',
            textAlign: TextAlign.center,
            style: kTitleAppbarStyleDetails,
          ),
          backgroundColor: kAppbarDetails,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
            ),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          )),
      body: ListView(
        children: [
          //----------------------------top containar---------------------------
          Container(
            width: double.infinity,
            height: size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.5),
                )
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
            ),
            child: Column(
              children: [
                //-------------------------image----------------------
                Stack(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      height: size.height * 0.4,
                      width: size.height * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(service.picture),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 5,
                            color: Colors.grey.withOpacity(0.5),
                          )
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                //--------------------------name &phone-------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: size.width,
                            // margin: EdgeInsets.only(left: 10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      service.serviceName,
                                      style: kTexttitleDetails,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 19,
                                  // ),
                                  Container(
                                    color: Color(0xBD535353),
                                    height: 44,
                                    width: 2,
                                  ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  Expanded(
                                    child: Text(
                                      'Phone  : ${service.servicePhoneNumber}',
                                      style: kTextBody,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        //---------------------stars rate-----------------------
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
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

                                double result = sums / snapshot.data.length;

                                return SmoothStarRating(
                                    allowHalfRating: false,
                                    starCount: 5,
                                    rating: result,
                                    size: 25,
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
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Text(
                service.serviceDescription,
                style: kTextBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
