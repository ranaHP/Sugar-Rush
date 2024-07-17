import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/classes/category.dart';
import 'package:the_sprinklr_bakery/classes/cupcake.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/component/title.dart';
import 'package:the_sprinklr_bakery/component/user/quantityPicker.dart';

class CakeList extends StatefulWidget {
  final String selectedCategory;

  const CakeList({super.key, required this.selectedCategory});

  @override
  State<CakeList> createState() => _CakeListState();
}

class _CakeListState extends State<CakeList> {
  List<Cupcake> cakeList = [];

  @override
  void didUpdateWidget(covariant CakeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      _loadInitialData();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final categories = await _fetchCategories();
    setState(() {
      cakeList = categories;
    });
  }

  Future<List<Cupcake>> _fetchCategories() async {
    QuerySnapshot querySnapshot;
    if (widget.selectedCategory == "") {
      querySnapshot =
          await FirebaseFirestore.instance.collection('cupcakes').get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('cupcakes')
          .where('categoryId', isEqualTo: widget.selectedCategory)
          .get();
    }

    return querySnapshot.docs.map((doc) {
      return Cupcake.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  void _addToCartDialog1(Cupcake cupcake) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
        return AddToCartDialog(cupcake: cupcake);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
    double unitWidthValue = MediaQuery.of(context).size.width * 0.001;

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cakeList.length,
              itemBuilder: (context, index) {
                final cake = cakeList[index];
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 0, bottom: 10, left: 0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 254, 252),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/cupcake1.png',
                        height: 100,
                      ),
                      Container(
                        width: (unitWidthValue * 1000) - 140,
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 10, left: 20, right: 20),
                        decoration: const BoxDecoration(
                          color: primaryColors,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cake.name,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: unitHeightValue * 20,
                                fontWeight: FontWeight.normal,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              cake.description,
                              style: TextStyle(
                                  fontSize: unitHeightValue * 16,
                                  fontWeight: FontWeight.normal,
                                  color:
                                      const Color.fromARGB(183, 219, 219, 219)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _addToCartDialog1(cake);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      return Colors.white;
                                    }),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 20,
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontSize: unitWidthValue * 34,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
