import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categorydb.dart';
import 'package:money_manager/screens/category/expense.dart';
import 'package:money_manager/screens/category/income.dart';

class categoryscreen extends StatefulWidget {
  const categoryscreen({Key? key}) : super(key: key);

  @override
  State<categoryscreen> createState() => _categoryscreenState();
}

class _categoryscreenState extends State<categoryscreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  @override
  void initState() {
    // TODO: implement initState
    _tab = TabController(length: 2, vsync: this);
    categorydb().RefreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(
                text: "Income",
              ),
              Tab(text: "Expense")
            ],
            controller: _tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
              child: TabBarView(
            controller: _tab,
            children: const [income(), expense()],
          ))
        ],
      ),
    );
  }
}
