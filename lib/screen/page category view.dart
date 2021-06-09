import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/model/model%20sortService.dart';
import 'package:syriaonline/provider/providerData.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/screen/page%20service%20info.dart';
import 'package:syriaonline/service/ServiceApi.dart';
import 'package:syriaonline/service/categoryApi.dart';
import 'package:syriaonline/widgets/category/horisantal.dart';

class ServiceView extends StatefulWidget {
  ServiceView({
    this.index,
    this.id,
    this.categoryName,
  });
  int index;
  int id;
  String categoryName;

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  //---------------------------refearsh-----------------------------------------
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  ScrollController _scrollController;
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      _scaffoldKey.currentState;
      setState(() {
        fdata();
        hdata();
        initState();
      });
    });
  }

  //----------------------------category horisantal-----------------------------

  List<CategoryModel> categories = [];
  Future<List<CategoryModel>> hdata() async {
    GetCategoryApi cat = GetCategoryApi();
    await cat.getcateg();
    List<CategoryModel> cats = await cat.getcateg();
    categories = cats;
    return categories;
  }

  int selectindex = 0;

  //----------------------------------------------------------------------------
  Map map;
  @override
  void initState() {
    _scrollController = new ScrollController();

    selectindex = widget.index;
    super.initState();
    map = Provider.of<Providerdata>(context, listen: false).mapcurrentlocation;
    id = Provider.of<Providerdata>(context, listen: false)
        .category
        .serviceCatogaryId;
  }

  TextEditingController src = TextEditingController();
  var src2;
  //---------------------------- service api -----------------------------------
  int id;
  List<SortService> services = [];

  Future<List<SortService>> fdata() async {
    GetServiceApi type = GetServiceApi(n: widget.id.toString());
    List<SortService> types = await type.getserv(map);
    services = types;
    return services;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.categoryName,
          style: kTitleAppbarStyle,
        ),
        backgroundColor: kAppBarColor,
      ),
      drawer: MyDrawer(),
      body: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 200,
        color: kchooseColor,
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: true,
        child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height * 0.230334,
                    ),
                    //---------------------gridview&list horisantal---------------
                    Container(
                      height: size.height * 0.65,
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: FutureBuilder<List<SortService>>(
                            future: fdata(),
                            builder: (BuildContext ctx,
                                AsyncSnapshot<List<SortService>> snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else {
                                return snapshot.data.length != 0
                                    ? Container(
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: services.length,
                                            gridDelegate:
                                                new SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 2 / 2,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 20,
                                            ),
                                            itemBuilder: (context, index) {
                                              SortService c =
                                                  snapshot.data[index];
                                              return InkWell(
                                                onTap: () {
                                                  setService(
                                                      context: context,
                                                      val: c.service);
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ServiceInfo(
                                                              // service: c,
                                                              ),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 13),
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          spreadRadius: 3,
                                                          blurRadius: 5,
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                        )
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        //----------card grid-----------
                                                        Container(
                                                          height: 140,
                                                          width: 153,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              topLeft: Radius
                                                                  .circular(15),
                                                            ),
                                                            child:
                                                                Image.network(
                                                              c.service.picture,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 5,
                                                            bottom: 3,
                                                            top: 3,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                c.service
                                                                    .serviceName,
                                                                style:
                                                                    kTitleGridText,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    : Center(
                                        child: Text(
                                          'No Service Found !',
                                          style: kTextNote,
                                        ),
                                      );
                              }
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 50,
                          child:
                              // -------------HorisantalListView------------------
                              FutureBuilder<List<CategoryModel>>(
                            future: hdata(),
                            builder: (BuildContext ctx,
                                AsyncSnapshot<List<CategoryModel>> snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      CategoryModel categoreis =
                                          snapshot.data[index];
                                      return ReusubleTextButton(
                                        selectindex: selectindex,
                                        textChild:
                                            categoreis.servicesCatogaryName,
                                        index: index,
                                        categ: () {
                                          setState(() {
                                            selectindex = index;
                                          });
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => ServiceView(
                                                  index: index,
                                                  id: categoreis
                                                      .serviceCatogaryId,
                                                  categoryName: categoreis
                                                      .servicesCatogaryName),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    itemCount: categories.length,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                //------------------top container&search--------------------------
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.2 - 27,
                        decoration: BoxDecoration(
                          color: kchooseColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36)),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 30,
                                  offset: Offset(0, 7),
                                  color: Colors.black.withOpacity(.23),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: src,
                                    onChanged: (val) => {
                                      setState(() {
                                        src2 = val;
                                      })
                                    },
                                    decoration: InputDecoration(
                                      hintText: " Search",
                                      hintStyle: TextStyle(
                                          color: kAppBarColor.withOpacity(0.5)),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "img/icons/iconsearch.svg",
                                  width: 40,
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
