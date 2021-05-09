import 'package:flutter/material.dart';
import 'package:syriaonline/screen/page%20service%20info.dart';

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
              builder: (context) => ServiceInfo(),
            ),
          );
        },
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
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
