import 'package:flutter/material.dart';
import 'package:the_sprinklr_bakery/component/staticComponent.dart';
import 'package:the_sprinklr_bakery/component/title.dart';
import 'package:the_sprinklr_bakery/screen/home.dart';

class AdminStatics extends StatefulWidget {
  const AdminStatics({super.key});

  @override
  State<AdminStatics> createState() => _AdminStaticsState();
}

class _AdminStaticsState extends State<AdminStatics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const TitleComponent(
            title: "Static",
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
                      title: 'Customers',
                      value: '300',
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
                      title: 'Pending',
                      value: '10',
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
