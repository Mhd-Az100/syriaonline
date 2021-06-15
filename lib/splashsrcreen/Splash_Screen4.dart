import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/screen/page%20login.dart';
import 'dart:ui';

import 'package:syriaonline/screen/page%20signUp.dart';

class SplashScreen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(padding: EdgeInsets.all(5.0)),
        Container(
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 40),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'img/Catalogue2.svg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    SvgPicture.asset(
                      'img/Catalogue1.svg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ],
                ),
              )),
              Text('Add & views', textAlign: TextAlign.center, style: ksplash),
              Text(
                  'The User Can Add a New Service And \nBrowse The Existing Services',
                  textAlign: TextAlign.center,
                  style: ksplashtext),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF40BFCF)),
                    margin: EdgeInsets.only(left: 100, right: 100),
                    child: Center(
                      child: Text('Start',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
