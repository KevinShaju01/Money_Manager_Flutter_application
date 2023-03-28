import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/transactions/transactionmodel.dart';

abstract class transactiondbfunctions {
  Future<void> insert(transactionmodel value);
  Future<List<transactionmodel>> getdata();
  Future<void> RefreshTransUI();
  Future<void> delete(String key);
}

class transactiondb extends transactiondbfunctions {
  transactiondb._internal();
  static transactiondb instance = transactiondb._internal();
  factory transactiondb() => instance;
  @override
  Future<void> insert(transactionmodel value) async {
    // TODO: implement insert
    final tdb = await Hive.openBox<transactionmodel>("transaction-db4");
    await tdb.put(value.id, value);
    RefreshTransUI();
  }

  @override
  Future<List<transactionmodel>> getdata() async {
    // TODO: implement getdata
    final tdb = await Hive.openBox<transactionmodel>("transaction-db4");
    return tdb.values.toList();
  }

  ValueNotifier<List<transactionmodel>> trans = ValueNotifier([]);
  @override
  Future<void> RefreshTransUI() async {
    trans.value.clear();
    final all = await transactiondb.instance.getdata();
    all.sort((first, second) => second.date.compareTo(first.date));
    await Future.forEach(
        all, (transactionmodel value) => trans.value.add(value));
    trans.notifyListeners();
  }

  @override
  Future<void> delete(String key) async {
    // TODO: implement delete
    final tdb = await Hive.openBox<transactionmodel>("transaction-db4");
    tdb.delete(key);
  }
}
