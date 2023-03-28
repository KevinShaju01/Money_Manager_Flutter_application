import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/category/categorymodel.dart';

abstract class categorydbfunctions {
  Future<void> insert(categorymodel value);
  Future<List<categorymodel>> getdata();
  Future<void> delete(String key);
}

class categorydb implements categorydbfunctions {
  categorydb._internal();
  static categorydb instance = categorydb._internal();
  factory categorydb() {
    return instance;
  }
  @override
  Future<void> insert(categorymodel value) async {
    // TODO: implement insert
    final cdb = await Hive.openBox<categorymodel>("category-db");
    await cdb.put(value.id, value);
    RefreshUI();
  }

  @override
  Future<List<categorymodel>> getdata() async {
    // TODO: implement get
    final cdb = await Hive.openBox<categorymodel>("category-db");
    return cdb.values.toList();
  }

  ValueNotifier<List<categorymodel>> income = ValueNotifier([]);
  ValueNotifier<List<categorymodel>> expense = ValueNotifier([]);

  Future<void> RefreshUI() async {
    income.value.clear();
    expense.value.clear();
    final all = await categorydb().getdata();
    Future.forEach(all, (categorymodel cat) {
      if (cat.type == categorytype.income) {
        income.value.add(cat);
      } else {
        expense.value.add(cat);
      }
    });
    income.notifyListeners();
    expense.notifyListeners();
  }

  @override
  Future<void> delete(String key) async {
    // TODO: implement delete
    final cdb = await Hive.openBox<categorymodel>("category-db");
    await cdb.delete(key);
    RefreshUI();
  }
}
