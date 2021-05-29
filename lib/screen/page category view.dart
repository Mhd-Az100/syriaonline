import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/provider/providerData.dart';
import 'package:syriaonline/screen/page%20service%20info.dart';
import 'package:syriaonline/service/ServiceApi.dart';
import 'package:syriaonline/widgets/category/horisantal.dart';

class ServiceView extends StatefulWidget {
  ServiceView({this.id, this.categoryName});
  int id;
  String categoryName;

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
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
    map = {
      "user_location_x": position.latitude.toString(),
      "user_location_y": position.longitude.toString(),
    };
  }
  //---------------------------- service api -----------------------------------

  List<ServicesModel> services = [];
  Future<List<ServicesModel>> fdata() async {
    GetServiceApi type = GetServiceApi(n: widget.id.toString());
    // await type.getserv();

    List<ServicesModel> types = await type.getserv(map);
    services = types;
    return services;
  }

  @override
  void initState() {
    super.initState();
    fdata();
    currentlocatorPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          backgroundColor: kAppBarColor,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: Colors.white70,
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            child: FutureBuilder<List<ServicesModel>>(
              future: fdata(),
              builder: (BuildContext ctx,
                  AsyncSnapshot<List<ServicesModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: services.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          ServicesModel c = snapshot.data[index];
                          return InkWell(
                            onTap: () {
                              setService(context: context, val: c);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ServiceInfo(
                                        // service: c,
                                        )),
                              );
                            },
                            child: GridTile(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.network(
                                  c.picture,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              footer: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                ),
                                height: 50,
                                child: ListTile(
                                  leading: Text(
                                    c.serviceName,
                                    style: kTitleGridText,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.white,
            height: 70,
            child: HorisantalListView(),
          ),
        ]));
  }
}
