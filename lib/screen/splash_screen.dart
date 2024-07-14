import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/screen/login.dart';
import 'package:the_sprinklr_bakery/wrappers/authWrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/images/cupcake1.png',
                height: 300,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Where Every Bite",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w600,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(17, 8, 8, 8),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "is a Sweet ",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(17, 8, 8, 8),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Surprise.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primaryColors,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(17, 8, 8, 8),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(height: 1),
            const Padding(
              padding:
                  EdgeInsets.only(left: 20.0, right: 20, bottom: 20, top: 7),
              child: Center(
                child: Text(
                  "Indulge in a world of delightful cupcakes crafted with love. Whether you're looking for classic flavors or adventurous new tastes, our cupcakes are sure to bring a smile to your face. Shop now and treat yourself to something sweet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 71, 70, 70),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                            color: Color.fromARGB(21, 0, 0, 0),
                            offset: Offset(0, 0))
                      ]),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              child: Container(
                height: 50,
                width: 120,
                decoration: const BoxDecoration(
                    color: primaryColors,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(20, 0, 0, 0),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Loading...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(46, 8, 8, 8),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
