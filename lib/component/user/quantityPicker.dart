import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/classes/cupcake.dart';

class AddToCartDialog extends StatefulWidget {
  final Cupcake cupcake;

  const AddToCartDialog({Key? key, required this.cupcake}) : super(key: key);

  @override
  _AddToCartDialogState createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  final User? user = FirebaseAuth.instance.currentUser;

  int qty = 1;

  Future<void> _addToCart(int qty) async {
    if (user != null) {
      print(user?.email as String);

      // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      //     .collection('carts')
      //     .where('email', isEqualTo: user?.email as String)
      //     .get();

      final cupcakeMap = widget.cupcake.toJson();

      // if (querySnapshot.docs.isEmpty) {
      //   await FirebaseFirestore.instance.collection('carts').add({
      //     'email': user?.email as String,
      //     'items': [
      //       {
      //         'cake': cupcakeMap,
      //         'quantity': qty,
      //         'price': widget.cupcake.price * qty
      //       }
      //     ]
      //   });
      // } else {
      //   await FirebaseFirestore.instance
      //       .collection('carts')
      //       .doc(querySnapshot.docs.first.id)
      //       .update({
      //     'email': user?.email as String,
      //     'items': [
      //       {'cake': cupcakeMap, 'quantity': qty}
      //     ]
      //   });
      // }

      final cartRef = FirebaseFirestore.instance
          .collection('carts')
          .doc(user?.email as String);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(cartRef);
        if (snapshot.exists) {
          final cartData = snapshot.data() as Map<String, dynamic>;
          final cartItems = List<Map<String, dynamic>>.from(cartData['items']);
          final existingItemIndex = cartItems
              .indexWhere((item) => item['cake']['id'] == widget.cupcake.id);

          if (existingItemIndex >= 0) {
            cartItems[existingItemIndex]['quantity'] = qty;
            cartItems[existingItemIndex]['price'] =
                qty * cartItems[existingItemIndex]['cake']['price'];
          } else {
            cartItems.add({
              'cake': cupcakeMap,
              'quantity': qty,
              'price': widget.cupcake.price * qty
            });
          }

          transaction.update(cartRef, {'items': cartItems});
        } else {
          transaction.set(cartRef, {
            'email': user?.email as String,
            'items': [
              {'cake': cupcakeMap, 'quantity': qty}
            ]
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.001;

    return AlertDialog(
      title: Text(
        'Cupcake Count Control',
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
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10),
          // Container(
          //     child: Lottie.asset('assets/images/loading3.json', height: 140)),
          SizedBox(
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (qty > 1) {
                          qty--;
                        }
                      });
                    },
                  ),
                  Text(
                    qty.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                  ),
                ],
              ),
            ),
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
          child: const Text('Add'),
          onPressed: () {
            // Handle adding to cart logic here
            print('Adding ${qty}x ${widget.cupcake.name} to cart');
            _addToCart(qty);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
