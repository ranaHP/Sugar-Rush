import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/colors.dart';

class StaticComponent extends StatelessWidget {
  final String title;
  final String value;
  final Icon icon;
  final VoidCallback onTap;

  const StaticComponent(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.icon,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
    double multiplier = 13;

    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: screenWidth * 0.44,
          margin: EdgeInsets.only(bottom: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(13, 0, 0, 0),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      alignment: Alignment.center,
                      width: 80,
                      child: icon,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: multiplier * unitHeightValue,
                            fontWeight: FontWeight.w100,
                            color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                height: 2,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: primaryColors,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ],
          )),
    );
  }
}
