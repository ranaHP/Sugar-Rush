import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/service/auth_service.dart';

class CloudStoreService {
  User? user = AuthService().currentUser;
  FirebaseFirestore cloudService = FirebaseFirestore.instance;

  Future<String> route() async {
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        if (documentSnapshot.exists) {
          String role = documentSnapshot.get('rool');
          return role == "Owner" ? 'Owner' : 'Customer';
        } else {
          print('Document does not exist on the database');
        }
      } catch (e) {
        print('Error getting document: $e');
      }
    }
    return 'none';
  }
}
