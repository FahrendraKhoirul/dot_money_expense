import 'package:dot_money_expense/app/data/models/expense_model.dart';
import 'package:hive/hive.dart';

class HiveDatabaseService {
  // static Box<ExpenseModel>? _expenseBox;

  static Future<void> initDatabase() async {
    Hive.registerAdapter(ExpenseModelAdapter());
    // _expenseBox = await Hive.openBox<ExpenseModel>('expenses');
  }

  static Future<void> insertExpense(ExpenseModel expense) async {
    var box = await Hive.openBox<ExpenseModel>('expenses');
    await box.add(expense);
  }

  static Future<List<ExpenseModel>> getAllExpenses() async {
    var box = await Hive.openBox<ExpenseModel>('expenses');
    return box.values.toList();
  }

  static Future<void> deleteAllExpenses() async {
    var box = await Hive.openBox<ExpenseModel>('expenses');
    box.clear();
  }

  static Future<void> deleteExpense(int index) async {
    var box = await Hive.openBox<ExpenseModel>('expenses');
    await box.deleteAt(index);
  }

  static Future<void> updateExpense(int index, ExpenseModel expense) async {
    var box = await Hive.openBox<ExpenseModel>('expenses');
    await box.putAt(index, expense);
  }

  // static Future<void> updateExpense(int index, ExpenseModel expense) async {
  //   await _expenseBox?.putAt(index, expense);
  // }
}
