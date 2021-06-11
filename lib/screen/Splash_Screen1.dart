import 'package:flutter/material.dart';
import 'dart:ui';
import 'Splash_Screen2.dart';
import 'animation1.dart';

final String assetName = 'assets/Address.svg';

class SplashScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(padding: EdgeInsets.all(5.0)),
        Container(
          child: Column(
            children: [
              Center(
                child: AnimatedImage(),
              ),
              Padding(padding: EdgeInsets.only(top: 5.0)),
              Text(
                'Welcome To \nSyria Online',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF76C9D4),
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
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
              padding: EdgeInsets.only(top: 600.0),
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
