import 'package:flutter/material.dart';
import 'Splash_Screen3.dart';
import 'Splash_Screen1.dart';
import 'Splash_Screen2.dart';
import 'Splash_Screen4.dart';

class SimplePageSelector extends StatefulWidget {
  _SimplePageSelectorState createState() => _SimplePageSelectorState();
}

class _SimplePageSelectorState extends State<SimplePageSelector> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: Builder(
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(0.5),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 50,
                    child: TabBarView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SplashScreen1(),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SplashScreen2(),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SplashScreen3(),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SplashScreen4(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TabPageSelector(
                    selectedColor: Color(0xFF76C9D4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
