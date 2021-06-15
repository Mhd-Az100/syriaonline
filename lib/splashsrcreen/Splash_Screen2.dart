import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui';

import 'package:syriaonline/constant/constent.dart';

final String assetName = 'img/directions-animate.svg';

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
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'img/Directions1.svg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      SvgPicture.asset(
                        'img/Directions2.svg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
              Text('Google Map', textAlign: TextAlign.center, style: ksplash),
              Text(
                  "Lets you know the places on the map\nand add your own Services on the Map\n Depends On User's Location",
                  textAlign: TextAlign.center,
                  style: ksplashtext),
            ],
          ),
        ),
        // Container(
        //   child: GestureDetector(
        //     onTap: () => Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => SplashScreen3(),
        //       ),
        //     ),
        //     child: Padding(
        //       padding: EdgeInsets.only(top: 630.0),
        //       child: Container(
        //         height: 50,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(30),
        //             color: Color(0xFF40BFCF)),
        //         margin: EdgeInsets.only(left: 100, right: 100),
        //         child: Center(
        //           child: Text('Next',
        //               style: TextStyle(
        //                 color: Color(0xFFFFFFFF),
        //                 fontSize: 30,
        //                 fontWeight: FontWeight.bold,
        //                 decoration: TextDecoration.none,
        //               )),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
