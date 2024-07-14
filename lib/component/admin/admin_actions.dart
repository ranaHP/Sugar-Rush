import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/component/actionComponent.dart';
import 'package:the_sprinklr_bakery/component/title.dart';
import 'package:the_sprinklr_bakery/screen/home.dart'; // Example page

class AdminActions extends StatefulWidget {
  const AdminActions({super.key});

  @override
  State<AdminActions> createState() => _AdminActionsState();
}

class _AdminActionsState extends State<AdminActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const TitleComponent(
            title: "Actions",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionComponent(
                      title: 'Category Manage',
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
                    ActionComponent(
                      title: 'Cupcake Manage',
                      icon: const Icon(
                        Icons.cake_outlined,
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
                    ActionComponent(
                      title: 'Order Manage',
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
                    ActionComponent(
                      title: 'Customer Manage',
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
