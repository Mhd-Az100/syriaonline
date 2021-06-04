import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/screen/page%20category%20view.dart';
import '../constant/constent.dart';
import '../service/categoryApi.dart';
import '../model/model category .dart';
import 'package:syriaonline/provider/providerData.dart';

// ignore: must_be_immutable
class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  void initState() {
    super.initState();
    currentlocatorPosition();
  }

  //---------------------for current location-----------------------------------
  Map map;
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  void currentlocatorPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngposition = LatLng(position.latitude, position.longitude);
    print("x= ${position.latitude}");
    print("y= ${position.longitude}");
    print(latLngposition);
    setState(() {
      map = {
        "user_location_x": position.latitude.toString(),
        "user_location_y": position.longitude.toString(),
      };
    });
  }
  //---------------------------- category api ----------------------------------

  List<CategoryModel> categories = [];

  Future<List<CategoryModel>> fdata() async {
    GetCategoryApi cat = GetCategoryApi();
    // await cat.getcateg();

    List<CategoryModel> cats = await cat.getcateg();
    categories = cats;
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kchooseColor,
      drawer: MyDrawer(),
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: kAppBarColor,
          title: Text(
            'Category',
            style: kTitleAppbarStyle,
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          offset: Offset(0, -2),
                          color: Colors.black.withOpacity(.5),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: kCardHomeColor),
                ),
                FutureBuilder<List<CategoryModel>>(
                  future: fdata(),
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<CategoryModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 120),
                        itemBuilder: (BuildContext ctx, int index) {
                          CategoryModel categoreis = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              //---------------------for view page -------------
                              setcategory(context: context, val1: categoreis);
                              setcurrentlocation(context: context, val2: map);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ServiceView(
                                    index: index,
                                    id: categoreis.serviceCatogaryId,
                                    categoryName:
                                        categoreis.servicesCatogaryName,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    offset: Offset(0, 5),
                                    color: Colors.black.withOpacity(.5),
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              margin: EdgeInsets.all(20),
                              height: 175,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        categoreis.picture,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                              gradient: kBackTitleColor),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                categoreis.servicesCatogaryName,
                                                style: kTitlelstText),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: categories.length,
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
