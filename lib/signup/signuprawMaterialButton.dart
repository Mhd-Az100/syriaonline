import 'package:flutter/material.dart';
import 'package:syriaonline/constant/constent.dart';

class ReusableRaisedButton extends StatelessWidget {
  final color;
  final String text;
  final Function onpressed;
  ReusableRaisedButton(
      {this.color, @required this.text, @required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onpressed,
      padding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      child: Container(
        height: 40,
        width: 180,
        decoration: BoxDecoration(
            gradient: color,
            borderRadius: BorderRadius.all(
              Radius.circular(80.0),
            )),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          text.toString(),
          textAlign: TextAlign.center,
          style: kTextButton,
        ),
      ),
    );
  }
}
