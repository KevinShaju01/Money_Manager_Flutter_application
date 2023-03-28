import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/db/transaction/transactiondb.dart';
import 'package:money_manager/models/category/categorymodel.dart';
import 'package:money_manager/models/transactions/transactionmodel.dart';
import 'package:money_manager/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(categorymodelAdapter().typeId)) {
    Hive.registerAdapter(categorymodelAdapter());
  }
  if (!Hive.isAdapterRegistered(categorytypeAdapter().typeId)) {
    Hive.registerAdapter(categorytypeAdapter());
  }
  if (!Hive.isAdapterRegistered(transactionmodelAdapter().typeId)) {
    Hive.registerAdapter(transactionmodelAdapter());
  }
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    transactiondb.instance.RefreshTransUI();
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: const homescreen());
  }
}
