import 'package:flutter/material.dart';

class TitleComponent extends StatefulWidget {
  final String title;

  const TitleComponent({Key? key, required this.title}) : super(key: key);

  @override
  State<TitleComponent> createState() => _TitleComponentState();
}

class _TitleComponentState extends State<TitleComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14, top: 20),
      alignment: Alignment.topLeft,
      child: Text(
        widget.title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
