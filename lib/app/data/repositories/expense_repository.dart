import 'package:dot_money_expense/app/data/models/expense_model.dart';
import 'package:dot_money_expense/app/data/services/hive_db_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseRepository {
  static Future<void> insertExpense(
      String name, String category, DateTime date, int nominal) async {
    final expense = ExpenseModel(
        name: name, category: category, date: date, nominal: nominal);
    var box = await Hive.openBox<ExpenseModel>('expenses');
    box.add(expense);
  }

  static Future<List<ExpenseModel>> getAllExpenses() async {
    return await HiveDatabaseService.getAllExpenses();
  }

  static Future<void> deleteAllExpenses() async {
    return await HiveDatabaseService.deleteAllExpenses();
  }

  static Future<void> deleteExpense(int index) async {
    await HiveDatabaseService.deleteExpense(index);
  }

  static Future<void> updateExpense(int index, ExpenseModel expense) async {
    await HiveDatabaseService.updateExpense(index, expense);
  }
}
