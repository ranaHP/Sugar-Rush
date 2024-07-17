import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/screen/home.dart';
import 'package:the_sprinklr_bakery/screen/shoppingCart.dart';

class UserPageHeader extends StatelessWidget {
  final String title_1;
  final String title_2;
  final bool back_visible;
  final String sub_title;
  const UserPageHeader(
      {super.key,
      required this.title_1,
      required this.title_2,
      required this.sub_title,
      required this.back_visible});

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
    double multiplier1 = 49;
    double multiplier2 = 17;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (back_visible)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 89, 88, 88),
                                size: 18.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                    fontFamily: "Poppings", color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
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
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    if (!back_visible)
                      Container(
                          padding: const EdgeInsets.all(.05),
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserShoppingCart()),
                              );
                            },
                            icon: const Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Color.fromARGB(255, 115, 115, 115),
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title_1,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: multiplier1 * unitHeightValue,
                    fontWeight: FontWeight.w600,
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Color.fromARGB(17, 0, 0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  title_2,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primaryColors,
                    fontSize: multiplier1 * unitHeightValue,
                    fontWeight: FontWeight.w700,
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Color.fromARGB(17, 0, 0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  sub_title,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 125, 125, 125),
                    fontSize: multiplier2 * unitHeightValue,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
