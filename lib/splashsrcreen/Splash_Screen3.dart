import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui';

import 'package:syriaonline/constant/constent.dart';

class SplashScreen3 extends StatelessWidget {
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
                        'img/Review1.svg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      SvgPicture.asset(
                        'img/Review2.svg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      SvgPicture.asset(
                        'img/Review3.svg',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
              Text('Comments , Reviews',
                  textAlign: TextAlign.center, style: ksplash),
              Text(
                  'The User can Review the Services and Add the Comment On Any Service He Want',
                  textAlign: TextAlign.center,
                  style: ksplashtext),
            ],
          ),
        ),
        // Container(
        //   child: GestureDetector(
        //     onTap: () => Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => SplashScreen4(),
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
