import 'package:delivery_app/extension/color_extension.dart';
import 'package:delivery_app/models/categories_model.dart';
import 'package:delivery_app/screen/categories_screen.dart';
import 'package:delivery_app/screen/profile_screen.dart';
import 'package:delivery_app/screen/store_screen.dart';
import 'package:flutter/material.dart';

class TabbarControler extends StatefulWidget {
  @override
  _TabbarControlerState createState() => _TabbarControlerState();
}

class _TabbarControlerState extends State<TabbarControler> {
  int selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30, fontWeight: FontWeight.bold
  );

  final listItem = [CategoriesScreen(), StoreScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      print("$selectedIndex");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: listItem[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.category),
              ),
              BottomNavigationBarItem(
                label: "",
                  icon: Icon(Icons.add_shopping_cart),
              ),
              BottomNavigationBarItem(
                label: "",
                  icon: Icon(Icons.person),
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: HexColor.fromHex("#7203FF"),
            onTap:  _onItemTapped,
          ),
        )
    );
  }
}
