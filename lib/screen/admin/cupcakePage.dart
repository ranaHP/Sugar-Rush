import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/classes/category.dart';
import 'package:the_sprinklr_bakery/classes/cupcake.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/component/admin/admin_page_header.dart';
import 'package:the_sprinklr_bakery/screen/admin/cupcakePage.dart';

class CupCakeManagePage extends StatefulWidget {
  const CupCakeManagePage({super.key});

  @override
  State<CupCakeManagePage> createState() => _CupCakeManagePageState();
}

class _CupCakeManagePageState extends State<CupCakeManagePage> {
  bool isTextVisible = false;
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

  void _deleteCategory(String id) async {
    await FirebaseFirestore.instance.collection('cupcakes').doc(id).delete();
    setState(() {
      cupcakesList.removeWhere((category) => category.id == id);
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

  void _addCupcake(
      String categoryId, String name, String description, double price) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('cupcakes').add({
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
    });
    setState(() {
      cupcakesList.add(Cupcake(
        id: docRef.id,
        categoryId: categoryId,
        name: name,
        description: description,
        price: price,
      ));
    });
  }

  void _updateCupcake(String id, String categoryId, String name,
      String description, double price) async {
    await FirebaseFirestore.instance.collection('cupcakes').doc(id).update({
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
    });

    setState(() {
      final index = cupcakesList.indexWhere((cupcake) => cupcake.id == id);
      if (index != -1) {
        cupcakesList[index] = Cupcake(
          id: id,
          categoryId: categoryId,
          name: name,
          description: description,
          price: price,
        );
      }
    });
  }

  void _showEditCupcakeDialog(Cupcake cupcake) {
    String name = cupcake.name;
    String description = cupcake.description;
    double price = cupcake.price;
    String selectedCategoryId = cupcake.categoryId;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
        return AlertDialog(
          title: Text(
            'Edit Cupcake',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 30 * unitHeightValue,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                items: categoryList.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.title),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCategoryId = value!;
                },
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
                controller: TextEditingController(text: name),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
                controller: TextEditingController(text: description),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
                },
                controller: TextEditingController(text: price.toString()),
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
                _updateCupcake(
                    cupcake.id, selectedCategoryId, name, description, price);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddCupcakeDialog() {
    String name = '';
    String description = '';
    double price = 0.0;
    String selectedCategoryId =
        categoryList.isNotEmpty ? categoryList[0].id : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
        return AlertDialog(
          title: Text(
            'Add Cupcake',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 30 * unitHeightValue,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              if (categoryList.length > 0)
                DropdownButtonFormField<String>(
                  value: selectedCategoryId,
                  items: categoryList.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.title),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCategoryId = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
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
                _addCupcake(selectedCategoryId, name, description, price);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;
    double unitWidthtValue = MediaQuery.of(context).size.width * 0.001;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const AdminPageHeader(
              title_1: "Cupcake",
              title_2: "Manage",
              sub_title: "Manage Cupcake",
              back_visible: true,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Cupcake>>(
                future: _fetchCupcakes(),
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
                        final cupcake = categories[index];
                        return Hero(
                          tag: 'cupcake_${cupcake.id}',
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
                                        cupcake.name,
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
                                      SizedBox(
                                        width: (unitWidthtValue * 1000) - 160,
                                        child: Text(
                                          '${cupcake.description}',
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
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: unitWidthtValue * 300,
                                        child: Text(
                                          'Rs ${cupcake.price.toString()}.00',
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
                                      ),
                                      if (isTextVisible)
                                        const SizedBox(height: 10),
                                      if (isTextVisible)
                                        Text(
                                          cupcake.description,
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
                                        tooltip: 'Edit cupcake',
                                        onPressed: () {
                                          _showEditCupcakeDialog(cupcake);
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
                                          // _deletecupcake(cupcake.id);
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
              onPressed: _showAddCupcakeDialog,
              child: const Icon(Icons.add),
              tooltip: 'Add cupcake',
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
