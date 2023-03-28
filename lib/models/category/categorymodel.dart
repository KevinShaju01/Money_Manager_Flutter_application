import 'package:hive/hive.dart';
part 'categorymodel.g.dart';

@HiveType(typeId: 2)
enum categorytype {
  @HiveField(0)
  income,
  @HiveField(1)
  expense
}

@HiveType(typeId: 1)
class categorymodel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDelete;
  @HiveField(3)
  final categorytype type;

  categorymodel(
      {required this.id,
      required this.name,
      this.isDelete = false,
      required this.type});
}
