import 'package:flutter/material.dart';
import 'package:money_manager/screens/addtransaction/addtransaction.dart';

import 'package:money_manager/screens/category/category.dart';
import 'package:money_manager/screens/category/categorypopup.dart';

import 'package:money_manager/screens/home/widgets/BottomNavigation.dart';
import 'package:money_manager/screens/transactions/transaction.dart';

class homescreen extends StatelessWidget {
  const homescreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectindex = ValueNotifier(0);
  final pages = const [transactionscreen(), categoryscreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 194, 224, 247),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectindex,
              builder: (ctx, int val, W) {
                return pages[val];
              })),
      bottomNavigationBar: const BottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectindex.value == 0) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const addtransaction()));
          } else {
            categorypopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Money Manager"),
      ),
    );
  }
}
