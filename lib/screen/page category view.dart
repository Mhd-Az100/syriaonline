import 'package:flutter/material.dart';
import 'package:syriaonline/constant/drawer.dart';
import '../category/horisantal.dart';
import '../category/theGridView.dart';

class ServiceView extends StatelessWidget {
  final int id;
  final String categoryName;
  ServiceView(this.id, this.categoryName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
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
