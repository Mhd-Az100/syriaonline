import 'package:flutter/material.dart';

class HorisantalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ReusubleTextButton(textChild: 'Hotels', categ: () {}),
          ReusubleTextButton(textChild: 'Restaurants', categ: () {}),
          ReusubleTextButton(textChild: 'Hospitals', categ: () {}),
          ReusubleTextButton(textChild: 'Pharmacies', categ: () {}),
          ReusubleTextButton(textChild: 'Schools', categ: () {}),
          ReusubleTextButton(textChild: 'Centers', categ: () {}),
        ],
      ),
    );
  }
}

class ReusubleTextButton extends StatelessWidget {
  final Function categ;
  final String textChild;
  ReusubleTextButton({@required this.textChild, @required this.categ});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 110,
        child: RawMaterialButton(
          child: Text(
            textChild,
            textAlign: TextAlign.center,
          ),
          onPressed: categ,
          fillColor: Color(0xFFDFDFDF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      SizedBox(
        width: 10.0,
      )
    ]);
  }
}
