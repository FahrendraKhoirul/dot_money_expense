import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:dot_money_expense/app/constants/category_item.dart';
import 'package:dot_money_expense/app/data/models/expense_model.dart';
import 'package:dot_money_expense/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseListTileComponent extends StatelessWidget {
  const ExpenseListTileComponent(
      {super.key, required this.expense, required this.indexInBox});
  final ExpenseModel expense;
  final int indexInBox;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ADD_EXPENSE,
            arguments: {"id": indexInBox, "expense": expense});
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.08), // Shadow color
              spreadRadius: 4, // Spread radius
              blurRadius: 8, // Blur radius
              offset: const Offset(0, 4), // Offset in the x, y direction
            ),
          ],
        ),
        child: ListTile(
          // dense: true,
          leading: Image.asset(
              CategoryItem.category[expense.category]['icon_path'],
              color: CategoryItem.category[expense.category]['color']),
          title: Text(expense.name!, style: AppTextStyles.paragraphMedium),
          trailing: Text(
            "Rp. ${expense.nominal.toString()}",
            style: AppTextStyles.paragraphSemibold,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }
}
