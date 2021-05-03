import 'package:flutter/material.dart';
import 'package:syriaonline/screen/page%20service%20details.dart';
import 'restaurantS.dart';

class RS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      physics:
          NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      shrinkWrap: true,
      padding: EdgeInsets.all(25),
      children: restaurants
          .map(
            (e) => ReusubleCard(
              img: Image.asset(
                (e.img),
                fit: BoxFit.cover,
              ),
              name: e.name,
            ),
          )
          .toList(),
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}

class ReusubleCard extends StatelessWidget {
  final img;
  final String name;
  ReusubleCard({this.img, this.name});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Details(),
            ),
          );
        },
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: img,
          ),
          footer: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            height: 50,
            child: ListTile(
              leading: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
