import 'package:flutter/material.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/model/model%20services.dart';
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceInfo(id: c.serviceId)),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ));
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
