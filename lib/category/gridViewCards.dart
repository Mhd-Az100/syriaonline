import 'package:flutter/material.dart';

class ReusubleCard extends StatelessWidget {
  final img;
  final String name;
  ReusubleCard({this.img, this.name});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
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
