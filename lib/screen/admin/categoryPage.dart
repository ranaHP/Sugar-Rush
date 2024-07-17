import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_sprinklr_bakery/classes/category.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/component/admin/admin_page_header.dart';
import 'package:the_sprinklr_bakery/service/route_service.dart';

class CupcakeCategoryList extends StatefulWidget {
  @override
  _CupcakeCategoryListState createState() => _CupcakeCategoryListState();
}

class _CupcakeCategoryListState extends State<CupcakeCategoryList> {
  bool isTextVisible = false;
  List<CupcakeCategory> cupcakeCategories = [];

  void _addCategory(String title, String subtitle, String description) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('cupcake_categories').add({
      'title': title,
      'subtitle': subtitle,
      'description': description,
    });
    setState(() {
      cupcakeCategories.add(CupcakeCategory(
        id: docRef.id,
        title: title,
        subtitle: subtitle,
        description: description,
      ));
    });
  }

  void _updateCategory(
      String id, String title, String subtitle, String description) async {
    await FirebaseFirestore.instance
        .collection('cupcake_categories')
        .doc(id)
        .update({
      'title': title,
      'subtitle': subtitle,
      'description': description,
    });
    setState(() {
      final index =
          cupcakeCategories.indexWhere((category) => category.id == id);
      if (index != -1) {
        cupcakeCategories[index] = CupcakeCategory(
          id: id,
          title: title,
          subtitle: subtitle,
          description: description,
        );
      }
    });
  }

  void _deleteCategory(String id) async {
    await FirebaseFirestore.instance
        .collection('cupcake_categories')
        .doc(id)
        .delete();
    setState(() {
      cupcakeCategories.removeWhere((category) => category.id == id);
    });
  }

  void _showAddCategoryDialog() {
    String title = '';
    String subtitle = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
        return AlertDialog(
          title: Text(
            'Add Cupcake Category',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 30 * unitHeightValue,
              fontWeight: FontWeight.w600,
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: Color.fromARGB(17, 0, 0, 0),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              // Container(
              //     child:
              //         Lottie.asset('assets/images/loading3.json', height: 140)),
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Subtitle'),
                onChanged: (value) {
                  subtitle = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _addCategory(title, subtitle, description);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCategoryDialog(CupcakeCategory category) {
    String title = category.title;
    String subtitle = category.subtitle;
    String description = category.description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
        return AlertDialog(
          title: Text(
            'Edit Cupcake Category',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 30 * unitHeightValue,
              fontWeight: FontWeight.w600,
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: Color.fromARGB(17, 0, 0, 0),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              Container(
                  child:
                      Lottie.asset('assets/images/loading3.json', height: 140)),
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
                controller: TextEditingController(text: title),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Subtitle'),
                onChanged: (value) {
                  subtitle = value;
                },
                controller: TextEditingController(text: subtitle),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
                controller: TextEditingController(text: description),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _updateCategory(category.id, title, subtitle, description);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const AdminPageHeader(
              title_1: "Cupcake",
              title_2: "Categories",
              sub_title: "Manage Cupcake Categories",
              back_visible: true,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<CupcakeCategory>>(
                future: _fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories found'));
                  } else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Hero(
                          tag: 'cupcake_category_${category.id}',
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 250, 247, 247),
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(16, 13, 13, 13)
                                      .withOpacity(0.16),
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(13),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category.title,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 24 * unitHeightValue,
                                          fontWeight: FontWeight.w300,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color:
                                                  Color.fromARGB(17, 8, 8, 8),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        category.subtitle,
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 36, 36, 36),
                                          fontSize: 18 * unitHeightValue,
                                          fontWeight: FontWeight.w300,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color:
                                                  Color.fromARGB(17, 8, 8, 8),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      if (isTextVisible)
                                        const SizedBox(height: 10),
                                      if (isTextVisible)
                                        Text(
                                          category.description,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: primaryColors,
                                    borderRadius: BorderRadius.circular(9),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(16, 13, 13, 13)
                                            .withOpacity(0.16),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, size: 16),
                                        color: Colors.white,
                                        tooltip: 'Edit Category',
                                        onPressed: () {
                                          _showEditCategoryDialog(category);
                                        },
                                      ),
                                      Container(
                                        width: 1,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 16,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Color.fromARGB(21, 0, 0, 0),
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        color: Colors.white,
                                        onPressed: () {
                                          _deleteCategory(category.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _showAddCategoryDialog,
              child: const Icon(Icons.add),
              tooltip: 'Add Category',
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {});
              },
              child: const Icon(Icons.refresh),
              tooltip: 'Refresh Categories',
            ),
          ],
        ),
      ),
    );
  }
}
