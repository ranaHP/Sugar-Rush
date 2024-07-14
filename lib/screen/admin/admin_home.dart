import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/component/admin/admin_actions.dart';
import 'package:the_sprinklr_bakery/component/admin/admin_static.dart';
import 'package:the_sprinklr_bakery/service/auth_service.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
    double multiplier1 = 49;
    double multiplier2 = 17;
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
                                  spreadRadius: 2,
                                  blurRadius: 5,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Baker's",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: multiplier1 * unitHeightValue,
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
                        "Admin Panel.",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: primaryColors,
                          fontSize: multiplier1 * unitHeightValue,
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
                        "Manage your cupcake shop with ease.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 125, 125),
                          fontSize: multiplier2 * unitHeightValue,
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
          AdminStatics(),
          //------------------------------action----------------------
          AdminActions(),

          // -----------------------------action----------------------
          SizedBox(
            height: 30,
          ),
          Center(
              child: GestureDetector(
            onTap: () {
              AuthService().signOut();
            },
            child: Container(
              height: 50,
              width: 120,
              alignment: Alignment.center,
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
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                "Sign Out",
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
            ),
          ))
        ],
      )),
    ));
  }
}
