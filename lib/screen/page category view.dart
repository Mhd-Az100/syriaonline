import 'package:flutter/material.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/service/ServiceApi.dart';
import 'package:syriaonline/utils/allUrl.dart';
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
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        ListView(children: [
          new Padding(
            padding: EdgeInsets.only(top: 15, left: 10),
            child: Text('View :', style: TextStyle(color: Colors.grey)),
          ),
          HorisantalListView(),
          new Padding(
            padding: EdgeInsets.only(top: 15, left: 10),
            child: Text('Resent :', style: TextStyle(color: Colors.grey)),
          ),
          FutureBuilder<List<ServicesModel>>(
            future: fdata(),
            builder: (BuildContext ctx,
                AsyncSnapshot<List<ServicesModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: services.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
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
                    });
              }
            },
          ),
        ]),
      ]),
    );
  }
}
