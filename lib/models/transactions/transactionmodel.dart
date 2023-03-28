import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:money_manager/models/category/categorymodel.dart';
part 'transactionmodel.g.dart';

@HiveType(typeId: 3)
class transactionmodel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String purpose;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final categorytype type;
  @HiveField(5)
  final String category;

  transactionmodel(
      {required this.id,
      required this.purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category});
}
