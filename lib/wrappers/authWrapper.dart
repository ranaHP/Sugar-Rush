import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_sprinklr_bakery/screen/home.dart';
import 'package:the_sprinklr_bakery/screen/login.dart';
import 'package:the_sprinklr_bakery/service/auth_service.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          return user == null ? LoginPage() : HomePage();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
