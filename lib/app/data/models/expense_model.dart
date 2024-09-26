import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? category;
  @HiveField(3)
  DateTime? date;
  @HiveField(4)
  int? nominal;

  ExpenseModel({this.name, this.category, this.date, this.nominal});
}
