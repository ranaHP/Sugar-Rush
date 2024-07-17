import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/classes/category.dart';
import 'package:the_sprinklr_bakery/classes/cupcake.dart';
import 'package:the_sprinklr_bakery/component/staticComponent.dart';
import 'package:the_sprinklr_bakery/component/title.dart';
import 'package:the_sprinklr_bakery/screen/home.dart';

class AdminStatics extends StatefulWidget {
  const AdminStatics({super.key});

  @override
  State<AdminStatics> createState() => _AdminStaticsState();
}

class _AdminStaticsState extends State<AdminStatics> {
  List<Cupcake> cupcakesList = [];
  List<CupcakeCategory> categoryList = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final categories = await _fetchCategories();
    final cupcakes = await _fetchCupcakes();
    setState(() {
      categoryList = categories;
      cupcakesList = cupcakes;
    });
  }

  Future<List<Cupcake>> _fetchCupcakes() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cupcakes').get();
    return querySnapshot.docs.map((doc) {
      return Cupcake.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<List<CupcakeCategory>> _fetchCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cupcake_categories').get();
    return querySnapshot.docs.map((doc) {
      return CupcakeCategory.fromJson(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const TitleComponent(
            title: "Static",
            subTitle: '',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StaticComponent(
                      title: 'Total Sales',
                      value: '1000',
                      icon: const Icon(
                        Icons.category_outlined,
                        color: Color.fromARGB(255, 122, 122, 122),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    StaticComponent(
                      title: 'Revenue',
                      value: '3000',
                      icon: const Icon(
                        Icons.money,
                        color: Color.fromARGB(255, 122, 122, 122),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StaticComponent(
                      title: 'Cupcakes',
                      value: cupcakesList.length.toString(),
                      icon: const Icon(
                        Icons.shopping_basket_outlined,
                        color: Color.fromARGB(255, 122, 122, 122),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    StaticComponent(
                      title: 'Categories',
                      value: categoryList.length.toString(),
                      icon: const Icon(
                        Icons.people_outline_sharp,
                        color: Color.fromARGB(255, 122, 122, 122),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
