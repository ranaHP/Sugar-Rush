import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/service/auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(20, 0, 0, 0),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(.05),
                            margin: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10, right: 20),
                            child: const Icon(
                              Icons.account_circle,
                              color: Color.fromARGB(255, 254, 252, 252),
                              size: 28.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 175, 174, 174),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(20, 0, 0, 0),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What do you ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2.0,
                              color: Color.fromARGB(17, 0, 0, 0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Crave?",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: primaryColors,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2.0,
                              color: Color.fromARGB(17, 0, 0, 0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Indulge in a world of delightful cupcakes crafted ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 125, 125),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // ----------------------------------static-------------------

          // ----------------------------------sign out-------------------

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
      )),
    ));
  }
}
