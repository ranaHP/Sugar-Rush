import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_sprinklr_bakery/screen/admin/admin_home.dart';
import 'package:the_sprinklr_bakery/screen/home.dart';
import 'package:the_sprinklr_bakery/screen/loading.dart';
import 'package:the_sprinklr_bakery/screen/login.dart';
import 'package:the_sprinklr_bakery/screen/splash_screen.dart';
import 'package:the_sprinklr_bakery/service/auth_service.dart';
import 'package:the_sprinklr_bakery/service/route_service.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            return FutureBuilder<String>(
              future: CloudStoreService().route(),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.done) {
                  if (roleSnapshot.hasError) {
                    return LoginPage(); // Define an ErrorPage to handle this
                  }
                  String role = roleSnapshot.data ?? '';
                  return role == 'Owner' ? const AdminHomePage() : HomePage();
                } else {
                  return const LoadingPage();
                }
              },
            );
          }
        } else {
          return LoginPage();
        }
      },
    );
  }
}
