import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui';
import 'Splash_Screen2.dart';
import 'animation2.dart';

final String assetName = 'assets/directions-animate.svg';

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(padding: EdgeInsets.all(5.0)),
        Container(
          child: Column(
            children: [
              Center(
                child: AnimatedImage2(),
              ),
              Text(
                'GPS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF76C9D4),
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                  height: 1.8,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                'Lets you know the places on \nthe map and add your \nown services on the map',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF76C9D4),
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  height: 1.8,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SplashScreen2(),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 630.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF40BFCF)),
                margin: EdgeInsets.only(left: 100, right: 100),
                child: Center(
                  child: Text('Next',
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
        ),
      ],
    );
  }
}
