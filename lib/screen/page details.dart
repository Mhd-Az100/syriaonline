import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/provider/providerData.dart';
import 'package:syriaonline/service/ServiceApi.dart';
import 'package:syriaonline/service/detailsApi.dart';
import 'package:syriaonline/service/postApi.dart';
import 'package:syriaonline/utils/allUrl.dart';

class Detailes extends StatefulWidget {
  Detailes({this.id});
  int id;
  @override
  _DetailesState createState() => _DetailesState();
}

class _DetailesState extends State<Detailes> {
  String id;
  double ratingX = 0;

  void initState() {
    super.initState();
    id = Provider.of<Providerdata>(context, listen: false).serviceID;
    getpref();
  }

//-------------------------------------get service info-------------------------
  ServicesModel serviceinfo;
  Future<ServicesModel> fdata() async {
    GetInfo serv = GetInfo(n: id);
    ServicesModel service = await serv.getservinfo();
    serviceinfo = service;
    return serviceinfo;
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
        body: FutureBuilder<ServicesModel>(
            future: fdata(),
            builder: (BuildContext ctx, AsyncSnapshot<ServicesModel> snapshot) {
              ServicesModel servic = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                return Stack(
                  children: [
                    ListView(
                      children: [
                        //--------------------details service---------------------------------

                        Container(
                          height: 250,
                          child: GridTile(
                            child: Image.network(servic.picture),
                            footer: Container(
                              color: Colors.white70,
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Expanded(child: Text(servic.serviceName)),
                                    Expanded(
                                        child: SmoothStarRating(
                                            allowHalfRating: false,
                                            starCount: 5,
                                            rating: 2.5, //from data
                                            size: 20,
                                            isReadOnly: true,
                                            color: Colors.red,
                                            borderColor: Colors.red,
                                            spacing: 0.0)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
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
                                      color: Colors.yellow,
                                      borderColor: Colors.yellow,
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
                                      Map rated = {
                                        'rate_from_5': '$ratingX',
                                        'service_id': id.toString(),
                                        'account_id': iduser.toString(),
                                      };
                                      print(rated);
                                      setState(() {
                                        addrate(context, rated);
                                      });
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
                              servic.serviceDescription,
                              style: kTextBody,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              //  Stack(
              //   children: [
              //     ListView(
              //       children: [
              //         //--------------------details service---------------------------------

              //         Container(
              //           height: 250,
              //           child: GridTile(
              //             child: Image.asset('img/S3.jpg'),
              //             footer: Container(
              //               color: Colors.white70,
              //               child: ListTile(
              //                 leading: Text('name type servic '),
              //                 title: Row(
              //                   children: [
              //                     Expanded(child: Text('name service')),
              //                     Expanded(
              //                         child: SmoothStarRating(
              //                             allowHalfRating: false,
              //                             starCount: 5,
              //                             rating: 2.5, //from data
              //                             size: 20,
              //                             isReadOnly: true,
              //                             color: Colors.red,
              //                             borderColor: Colors.red,
              //                             spacing: 0.0)),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 25,
              //         ),
              //         Center(
              //             child: ratingX == 0
              //                 ? Text(
              //                     'Rate This Service ',
              //                     style: kTextBody,
              //                   )
              //                 : Container()),
              //         SizedBox(
              //           height: 25,
              //         ),
              //         //-------------------------------stars rate--------------------------

              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Center(
              //               child: ratingX == 0
              //                   ? SmoothStarRating(
              //                       allowHalfRating: false,
              //                       onRated: (v) {
              //                         ratingX = v;

              //                         //for data
              //                       },
              //                       starCount: 5,
              //                       rating: ratingX,
              //                       size: 40.0,
              //                       isReadOnly: false,
              //                       color: Colors.yellow,
              //                       borderColor: Colors.yellow,
              //                       spacing: 0.0)
              //                   : Container(),
              //             ),
              //             SizedBox(
              //               width: 15,
              //             ),
              //             ratingX == 0
              //                 ? IconButton(
              //                     icon: Icon(
              //                       Icons.check,
              //                       color: kiconColor,
              //                       size: 35,
              //                     ),
              //                     onPressed: () {
              //                       Map rated = {
              //                         'rate_from_5': '$ratingX',
              //                         'service_id': id.toString(),
              //                         'account_id': iduser.toString(),
              //                       };
              //                       print(rated);
              //                       setState(() {
              //                         addrate(context, rated);
              //                       });
              //                     })
              //                 : Container()
              //           ],
              //         ),
              //         SizedBox(
              //           height: 25,
              //         ),
              //         //-----------------------------descrubtion------------------------

              //         Container(
              //           width: double.infinity,
              //           child: Padding(
              //             padding: const EdgeInsets.all(10),
              //             child: Text(
              //               'A restaurant or an eatery, is a business that prepares and serves food and drinks to customers. ... By 1723 there were nearly four hundred cafés in Paris, but their menu was limited to simpler dishes or confectionaries, such as coffee, tea ',
              //               style: kTextBody,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            }));
  }
}
