import 'package:dot_money_expense/app/constants/app_colors.dart';
import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:dot_money_expense/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseSummaryComponenet extends GetView<HomeController> {
  const ExpenseSummaryComponenet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.blue,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pengeluaranmu hari ini",
                    style: AppTextStyles.paragraphSemibold
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 14.sp,
                  ),
                  Obx(
                    () => Text(
                      "Rp. ${controller.totalExpenseToday.value}",
                      style:
                          AppTextStyles.bigTitle.copyWith(color: Colors.white),
                    ),
                  ),
                ]),
          ),
        ),
        SizedBox(width: 19.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.teal,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pengeluaranmu bulan ini",
                    style: AppTextStyles.paragraphSemibold
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 14.sp,
                  ),
                  Obx(() => Text(
                        "Rp. ${controller.totalAllExpense.value}",
                        style: AppTextStyles.bigTitle
                            .copyWith(color: Colors.white),
                      ))
                ]),
          ),
        ),
      ],
    );
  }
}
