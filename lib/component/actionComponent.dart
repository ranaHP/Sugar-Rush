import 'package:flutter/material.dart';

class ActionComponent extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  const ActionComponent(
      {Key? key, required this.title, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.44,
        margin: EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(8)),
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
            icon,
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w100,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
