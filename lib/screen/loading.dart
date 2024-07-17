import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/colors.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primaryColors,
            strokeWidth: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Text("Loading.."),
        ],
      )),
    ));
  }
}
