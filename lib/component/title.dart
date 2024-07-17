import 'package:flutter/material.dart';

class TitleComponent extends StatefulWidget {
  final String title;
  final String subTitle;

  const TitleComponent({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  State<TitleComponent> createState() => _TitleComponentState();
}

class _TitleComponentState extends State<TitleComponent> {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 18, top: 20),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: unitHeightValue * 20,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 62, 62, 62),
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            widget.subTitle,
            style: TextStyle(
                fontSize: unitHeightValue * 16,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 135, 135, 135)),
          ),
        ],
      ),
    );
  }
}
