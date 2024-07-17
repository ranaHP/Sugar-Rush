import 'package:flutter/material.dart';

class SubTitleComponent extends StatefulWidget {
  final String title;

  const SubTitleComponent({Key? key, required this.title}) : super(key: key);

  @override
  State<SubTitleComponent> createState() => _SubTitleComponentState();
}

class _SubTitleComponentState extends State<SubTitleComponent> {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
      alignment: Alignment.topLeft,
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: unitHeightValue * 17,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
