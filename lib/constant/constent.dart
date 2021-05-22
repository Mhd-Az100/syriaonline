import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//--------------------------------------card------------------------------------
final kButtonLstcolor = Color(0xFFDFDFDF);

final kCardColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  colors: <Color>[Color(0xFF4286E6), Color(0xFF98BCDD)],
  tileMode: TileMode.repeated,
);
final kCardHomeColor = Color(0xA4FFFAFA);
final kTitleCardHomeText = GoogleFonts.alegreya(
    fontSize: 35, fontWeight: FontWeight.bold, color: Color(0xFFF3C52E));
final kTitlelstText = GoogleFonts.alegreya(
    fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xfffffffff));
final kTitleGridText = GoogleFonts.alegreya(
    fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xfffffffff));
//------------------------------------Appbar------------------------------------

final kAppBarColor = Color(0xFFF3C52E);
final kTitleAppbarStyle = GoogleFonts.pacifico(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final kTitleTextBody = GoogleFonts.pacifico(
  fontSize: 15,
  color: Colors.white,
);

//--------------------------------------body------------------------------------

final kBackTextColor = Color(0xFFF3C52E);
final kColorStarsRate = Colors.yellow;
final kColorStarsRated = Colors.red;
final kTextBody = GoogleFonts.petrona(fontSize: 17, color: Colors.black);
final kTextBodyApp = GoogleFonts.petrona(
    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

final kTitleText = GoogleFonts.pacifico(
  fontSize: 30,
  color: Colors.white,
);
final kTextFaild = TextStyle();
final kTextinfo = TextStyle();

//---------------------------------drawer---------------------------------------

final kColorbackCircleAvatar = Color(0xFF58637A);
final kBackCardColordrawer = Color(0xFF0880D1);

//------------------------------------button------------------------------------

final kButtonColor = Color(0xFF3159DA);
final kButtonSaveLocationColor = Color(0xFF3159DA);
final kTextButton = GoogleFonts.petrona(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

//-------------------------------------login------------------------------------

const klabelColor = Color(0xFFF3C52E);
const klabelTextButtoncolor = Color(0xFFF3C52E);
const klabelTextColor = Color(0xFF349DAF);
const kBottomContainerHight = 30.0;
const kLabelTextStyle = TextStyle(
  fontSize: 8.0,
  color: Color(0xFFA5EAEE),
);

//------------------------------------signup------------------------------------

const kTitleTextStyle = TextStyle(
  fontSize: 35,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.italic,
);
const kButtongradientColor = LinearGradient(
    colors: <Color>[Color(0xFFFAC310), Color(0xFFFCD31D), Color(0xFFFAEB64)]);
//------------------------------------icon--------------------------------------
const kiconColor = Color(0xFF0675B1);
const kHintStyle = TextStyle(color: Color(0xE8349CAF));
//---------------------------------Navigation Bar-------------------------------

final kBackgroundNAVcolor = Color(0xFF005B72);
final kCurveColorNAV = Colors.blue;
final kStartColorNAV = Colors.yellow;
final kEndColorNAV = Colors.blue;
