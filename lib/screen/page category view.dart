import 'package:flutter/material.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/service/ServiceApi.dart';
import 'package:syriaonline/widgets/category/gridViewCards.dart';
import 'package:syriaonline/widgets/category/horisantal.dart';

class ServiceView extends StatefulWidget {
  ServiceView({this.id, this.categoryName});
  int id;
  String categoryName;

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  List<ServicesModel> services = [];
  Future<List<ServicesModel>> fdata() async {
    GetServiceApi type = GetServiceApi(n: widget.id.toString());
    await type.getserv();

    List<ServicesModel> types = await type.getserv();
    services = types;
    return services;
  }

  @override
  void initState() {
    super.initState();
    fdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          backgroundColor: Color(0xFFFAB028),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: Colors.white70,
            ),
          ],
        ),
        drawer: MyDrawer(),
        // body: Stack(
        //   children: [
        //     FutureBuilder<List<ServicesModel>>(
        //       future: fdata(),
        //       builder: (BuildContext ctx,
        //           AsyncSnapshot<List<ServicesModel>> snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return Container(
        //               child: Center(child: CircularProgressIndicator()));
        //         } else {
        //           return Container(
        //             color: Colors.black,
        //             child: GridView.builder(
        //                 shrinkWrap: true,
        //                 itemCount: services.length,
        //                 gridDelegate:
        //                     new SliverGridDelegateWithFixedCrossAxisCount(
        //                   crossAxisCount: 2,
        //                   childAspectRatio: 2 / 2,
        //                   crossAxisSpacing: 20,
        //                   mainAxisSpacing: 20,
        //                 ),
        //                 itemBuilder: (context, index) {
        //                   ServicesModel c = snapshot.data[index];
        //                   return ReusubleCard(
        //                     img: Image.network(
        //                       c.picture,
        //                       fit: BoxFit.cover,
        //                     ),
        //                     name: c.serviceName,
        //                   );
        //                 }),
        //           );
        //         }
        //       },
        //     ),
        //     Positioned(
        //         top: 0,
        //         child: Container(
        //           height: 50,
        //           color: Colors.white,
        //           child: HorisantalListView(),
        //         )),
        //   ],
        // ),

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
                          return ReusubleCard(
                            img: Image.network(
                              c.picture,
                              fit: BoxFit.cover,
                            ),
                            name: c.serviceName,
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
