import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/classes/category.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/component/admin/admin_page_header.dart';
import 'package:the_sprinklr_bakery/component/subTitle.dart';
import 'package:the_sprinklr_bakery/component/title.dart';
import 'package:the_sprinklr_bakery/component/user/quantityPicker.dart';
import 'package:the_sprinklr_bakery/component/user/userCategory.dart';
import 'package:the_sprinklr_bakery/component/user/userCupCkae.dart';
import 'package:the_sprinklr_bakery/screen/admin/admin_home.dart';
import 'package:the_sprinklr_bakery/service/auth_service.dart';

import '../component/user/userPageHeader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = '';
  int qty = 1;
  void updateSelectedCategory(String value) {
    setState(() {
      selectedCategory = value;
      qty = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    Widget _buildBox({required Color color}) => Container(
        margin: EdgeInsets.all(12), height: 100, width: 200, color: color);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const UserPageHeader(
                title_1: "Welcome to ",
                title_2: "Sweet Delights!",
                sub_title: "Your One-Stop Shop for Delicious Cupcakes",
                back_visible: false),

            // ----------------------------------Categories-------------------
            const TitleComponent(
              title: "Explore Cupcake Categories",
              subTitle: 'Discover a World of Flavors',
            ),
            const SizedBox(
              height: 1,
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CakeCategoryList(onCategoryTap: updateSelectedCategory),
            ),

            const SizedBox(
              height: 1,
            ),
            // ----------------------------------Cup Cakes-------------------

            TitleComponent(
              title:
                  "Our Cake Creations ${selectedCategory == '' ? "(All)" : ""}",
              subTitle: 'Explore a Delicious Array of Cakes',
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CakeList(selectedCategory: selectedCategory),
            ),

            Center(
                child: GestureDetector(
              onTap: () {
                AuthService().signOut();
              },
              child: Container(
                height: 50,
                width: 120,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: primaryColors,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(20, 0, 0, 0),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(46, 8, 8, 8),
                        ),
                      ]),
                ),
              ),
            ))
          ],
        )),
      ),
    );
  }
}
