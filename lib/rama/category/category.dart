import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/service/ServiceApi.dart';

import 'package:flutter/material.dart';
import 'horisantal.dart';
import 'gridViewCards.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syriaonline/utils/allUrl.dart';

class ServiceView extends StatefulWidget {
  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  List<ServicesModel> services = [];

  Future<List<ServicesModel>> fdata() async {
    GetServiceApi type = GetServiceApi();
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
    // var url = Uri.parse(catogarytype + '${widget.id}');

    // Future<List<ServicesModel>> getserv() async {
    //   List<ServicesModel> servlist = [];

    //   http.Response res = await http.get(url);
    //   if (res.statusCode == 200) {
    //     var body = jsonDecode(res.body);

    //     for (var item in body) {
    //       servlist.add(ServicesModel.fromJson(item));
    //     }
    //     for (var i in servlist) {
    //       print(i.serviceName);
    //     }

    //     return servlist;
    //   } else {
    //     print('statuscode=${res.statusCode}');
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('asdasd'),
        backgroundColor: Color(0xFFFAB028),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: Colors.white70,
          ),
        ],
      ),
      //drawer: MyDrawer(),
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
          Container(
              child: FutureBuilder<List<ServicesModel>>(
                  future: fdata(),
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<ServicesModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return GridView.builder(
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
                          });
                    }
                  }))
        ]),
      ]),
    );
  }
}
