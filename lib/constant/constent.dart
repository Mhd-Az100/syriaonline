import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/////////////////////////////card////////////////////////////////////////

final kCardColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  colors: <Color>[Color(0xFF4286E6), Color(0xFF98BCDD)],
  tileMode: TileMode.repeated,
);
final kCardHomeColor = Color(0xA4FFFAFA);
final kTitleCardText = GoogleFonts.alegreya(
    fontSize: 35, fontWeight: FontWeight.bold, color: Color(0xFFF3C52E));

/////////////////////////////Appbar////////////////////////////////////////

final kTitleAppbarStyle = GoogleFonts.pacifico(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
final kAppBarColor = Color(0xFFF3C52E);

final kTitleTextBody = GoogleFonts.pacifico(
  fontSize: 15,
  color: Colors.white,
);

/////////////////////////////body////////////////////////////////////////

final kTextBody = GoogleFonts.petrona(fontSize: 17, color: Colors.black);
final kBackTextColor = Color(0xFFF3C52E);

final kTitleText = GoogleFonts.pacifico(
  fontSize: 30,
  color: Colors.white,
);
final kTextFaild = TextStyle();
final kTextinfo = TextStyle();

/////////////////////////////drawer////////////////////////////////////////

final kColorbackCircleAvatar = Color(0xFF58637A);
final kBackCardColordrawer = Color(0xFF0880D1);

/////////////////////////////button////////////////////////////////////////

final kButtonColor = Color(0xFF3159DA);
final kTextButton = GoogleFonts.petrona(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

//login////////////////////////////////////////////////////

const kBottomContainerHight = 30.0;
const klabelColor = Color(0xFFF3C52E);
const klabelTextColor = Color(0xFF349DAF);
const klabelTextButtoncolor = Color(0xFFF3C52E);
const kLabelTextStyle = TextStyle(
  fontSize: 8.0,
  color: Color(0xFFA5EAEE),
);

//signup/////////////////////////////////////////////////////////

const kTitleTextStyle = TextStyle(
  fontSize: 35,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.italic,
);
const kgradientColor = LinearGradient(
    colors: <Color>[Color(0xFFFAC310), Color(0xFFFCD31D), Color(0xFFFAEB64)]);
