import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/screens/home/home.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: homescreen.selectindex,
        builder: (BuildContext context, int updated, Widget) {
          return BottomNavigationBar(
            currentIndex: updated,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Transactions"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "Category")
            ],
            onTap: (index) {
              homescreen.selectindex.value = index;
            },
          );
        });
  }
}
