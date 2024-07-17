import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/colors.dart';
import 'package:the_sprinklr_bakery/component/title.dart';
import 'package:the_sprinklr_bakery/component/user/userPageHeader.dart';
import 'package:the_sprinklr_bakery/screen/splash_screen.dart';
import 'package:the_sprinklr_bakery/service/auth_service.dart';

class UserShoppingCart extends StatefulWidget {
  const UserShoppingCart({super.key});

  @override
  State<UserShoppingCart> createState() => _UserShoppingCartState();
}

class _UserShoppingCartState extends State<UserShoppingCart> {
  User? user;
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserAndCartData();
  }

  Future<void> _loadUserAndCartData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user!.email!;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('carts')
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          cartItems = List<Map<String, dynamic>>.from(
              querySnapshot.docs.first['items']);
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _updateCartItem(int index, int qty) async {
    if (user != null) {
      setState(() {
        isLoading = true;
      });
      String userEmail = user!.email!;
      final cartRef =
          FirebaseFirestore.instance.collection('carts').doc(userEmail);

      setState(() {
        cartItems[index]['quantity'] = qty;
      });

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(cartRef);
        if (snapshot.exists) {
          final cartData = snapshot.data() as Map<String, dynamic>;
          final cartItemsList =
              List<Map<String, dynamic>>.from(cartData['items']);
          cartItemsList[index]['quantity'] = qty;

          transaction.update(cartRef, {'items': cartItemsList});
        }
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _removeCartItem(int index) async {
    if (user != null) {
      setState(() {
        isLoading = true;
      });
      String userEmail = user!.email!;
      final cartRef =
          FirebaseFirestore.instance.collection('carts').doc(userEmail);

      setState(() {
        cartItems.removeAt(index);
      });

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(cartRef);
        if (snapshot.exists) {
          final cartData = snapshot.data() as Map<String, dynamic>;
          final cartItemsList =
              List<Map<String, dynamic>>.from(cartData['items']);
          cartItemsList.removeAt(index);

          transaction.update(cartRef, {'items': cartItemsList});
        }
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _checkout() async {
    if (user != null) {
      String userEmail = user!.email!;
      final orderData = {
        'email': userEmail,
        'status': 'pending',
        'items': cartItems,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Add order to 'orders' collection
      await FirebaseFirestore.instance.collection('orders').add(orderData);

      // Clear cart after checkout
      setState(() {
        cartItems.clear();
      });

      // Remove items from 'carts' collection
      await FirebaseFirestore.instance
          .collection('carts')
          .doc(userEmail)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        body: isLoading
            ? SplashScreen() // Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const UserPageHeader(
                      title_1: "Your",
                      title_2: "Shopping Cart!",
                      sub_title:
                          "Review and manage the cupcakes you love before placing your order.",
                      back_visible: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: cartItems.isNotEmpty
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                return Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Image.asset(
                                        'assets/images/cupcake1.png'),
                                    title: Text(item['cake']['name']),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Price: \$${item['cake']['price']}'),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                if (item['quantity'] > 1) {
                                                  _updateCartItem(index,
                                                      item['quantity'] - 1);
                                                }
                                              },
                                            ),
                                            Text(
                                                'Quantity: ${item['quantity']}'),
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                _updateCartItem(index,
                                                    item['quantity'] + 1);
                                              },
                                            ),
                                            Spacer(),
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                _removeCartItem(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'Your cart is empty!',
                                style: TextStyle(
                                    fontSize: unitHeightValue * 20,
                                    color: Colors.grey),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _checkout();
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Text(
                            "Checkout",
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
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
