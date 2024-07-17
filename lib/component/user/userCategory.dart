import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/classes/category.dart';
import 'package:the_sprinklr_bakery/colors.dart';

class CakeCategoryList extends StatefulWidget {
  final Function(String) onCategoryTap;
  const CakeCategoryList({Key? key, required this.onCategoryTap})
      : super(key: key);

  @override
  State<CakeCategoryList> createState() => _CakeCategoryListState();
}

class _CakeCategoryListState extends State<CakeCategoryList> {
  List<CupcakeCategory> categoryList = [];
  int activeCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final categories = await _fetchCategories();
    setState(() {
      categoryList = categories;
    });
  }

  Future<List<CupcakeCategory>> _fetchCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cupcake_categories').get();
    return querySnapshot.docs.map((doc) {
      return CupcakeCategory.fromJson(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  void _onCategoryTap(int index) {
    widget.onCategoryTap(categoryList[index].id);
    setState(() {
      activeCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final category = categoryList[index];
          return UCategoryCardComponent(
            category: category,
            isActive: index == activeCategoryIndex,
            onTap: () => _onCategoryTap(index),
          );
        },
      ),
    );
  }
}

class UCategoryCardComponent extends StatelessWidget {
  final CupcakeCategory category;
  final bool isActive;
  final VoidCallback onTap;

  const UCategoryCardComponent({
    Key? key,
    required this.category,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    Color getContainerColor(bool isActive) {
      if (isActive) {
        return primaryColors;
      } else {
        return Colors.white;
      }
    }

    Color getTextColor(bool isActive) {
      if (!isActive) {
        return primaryColors;
      } else {
        return Colors.white;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: getContainerColor(isActive),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 1,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/cupcake1.png',
                height: 60,
              ),
              Text(
                category.title,
                style: TextStyle(
                  color: getTextColor(isActive),
                  fontSize: unitHeightValue * 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
