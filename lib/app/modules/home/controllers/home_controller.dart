import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:dot_money_expense/app/constants/category_item.dart';
import 'package:dot_money_expense/app/data/models/expense_model.dart';
import 'package:dot_money_expense/app/data/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final RxList<ExpenseModel> expenses = <ExpenseModel>[].obs;
  final RxInt totalExpenseToday = 0.obs;
  final RxInt totalAllExpense = 0.obs;
  final RxMap<String, int> totalByCategory = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    expenses.value = await ExpenseRepository.getAllExpenses();
    // print("====print expenses==== ${expenses.value.length}");
    ExpenseRepository.getAllExpenses().then((value) => print(value));
    // print("====print expenses====${expenses.value}");
    calculateExpenses();
    calculateByCategory();
    // print(totalByCategory.value);
    update();
  }

  void calculateExpenses() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    totalExpenseToday.value = 0;
    totalAllExpense.value = 0;

    for (ExpenseModel expense in expenses) {
      totalAllExpense.value += expense.nominal!;

      if (expense.date!.day == today.day &&
          expense.date!.month == today.month &&
          expense.date!.year == today.year) {
        totalExpenseToday.value += expense.nominal!;
      }
    }
  }

  void calculateByCategory() {
    for (var key in CategoryItem.category.keys) {
      totalByCategory[key] = 0;
    }

    for (ExpenseModel expense in expenses) {
      totalByCategory[expense.category!] =
          (totalByCategory[expense.category!] ?? 0) + expense.nominal!;
    }
  }

  void deleteAllExpense() async {
    await ExpenseRepository.deleteAllExpenses();
    fetchExpenses();
    update();
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      messageText: Text(
        "Semua data berhasil dihapus",
        style: AppTextStyles.paragraphBold,
      ),
    ));
  }

  List<Map<int, ExpenseModel>> expenseTodayList() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    List<Map<int, ExpenseModel>> res = [];
    for (var element in expenses) {
      if (element.date!.day == today.day &&
          element.date!.month == today.month &&
          element.date!.year == today.year) {
        res.add({expenses.indexOf(element): element});
      }
    }
    return res;
  }

  List<Map<int, ExpenseModel>> expenseYesterdayList() {
    final now = DateTime.now();
    final yesterday = now.subtract(
      const Duration(days: 1),
    );

    List<Map<int, ExpenseModel>> res = [];
    for (var element in expenses) {
      if (element.date!.day == yesterday.day &&
          element.date!.month == yesterday.month &&
          element.date!.year == yesterday.year) {
        res.add({expenses.indexOf(element): element});
      }
    }

    return res;
  }

  List<Map<int, ExpenseModel>> expenseLongTimeAgo() {
    final now = DateTime.now();
    final longTimeAgo = now.subtract(
      const Duration(days: 2),
    );

    List<Map<int, ExpenseModel>> res = [];
    for (var element in expenses) {
      if (element.date!.isBefore(longTimeAgo)) {
        res.add({expenses.indexOf(element): element});
      }
    }

    return res;
  }
}
