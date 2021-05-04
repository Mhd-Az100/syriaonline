import 'package:flutter/material.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/service/ServiceApi.dart';
import '../widgets/category/horisantal.dart';
import '../widgets/category/theGridView.dart';

class ServiceView extends StatefulWidget {
  final int id;
  final String categoryName;
  ServiceView(this.id, this.categoryName);

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  List<ServicesModel> services = [];

  Future<List<ServicesModel>> fdata() async {
    GetServiceApi type = GetServiceApi(widget.id);
    await type.getserv();

    List<ServicesModel> types = await type.getserv();
    services = types;
    return services;
  }

  @override
  void initState() {
    super.initState();
    print(fdata());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName + '${widget.id}'),
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
          Container(child: RS()),
        ]),
      ]),
    );
  }
}
