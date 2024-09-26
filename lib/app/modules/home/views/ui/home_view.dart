import 'package:dot_money_expense/app/constants/app_colors.dart';
import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:dot_money_expense/app/modules/home/views/components/expense_by_category_component.dart';
import 'package:dot_money_expense/app/modules/home/views/components/expense_item_list_tile_component.dart';
import 'package:dot_money_expense/app/modules/home/views/components/expense_summary_component.dart';
import 'package:dot_money_expense/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Halo, User!",
                            style: AppTextStyles.bigTitle
                                .copyWith(color: AppColors.grey1),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.deleteAllExpense();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text("Jangan lupa catat keuanganmu setiap hari!",
                          style: AppTextStyles.paragraphMedium
                              .copyWith(color: AppColors.grey3)),
                      SizedBox(
                        height: 20.h,
                      ),
                      const ExpenseSummaryComponenet(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Pengeluaran berdasarkan kategori",
                        style: AppTextStyles.bigTitle
                            .copyWith(color: AppColors.grey1),
                      ),
                    ],
                  )),
              // ======= HORIZONTAL LISTVIEW
              const ExpenseByCategory(),
              Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hari ini",
                        style: AppTextStyles.bigTitle
                            .copyWith(color: AppColors.grey1),
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            controller.expenseTodayList().isNotEmpty,
                        widgetBuilder: (context) => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.expenseTodayList().length,
                          itemBuilder: (context, index) {
                            // print("===expense====${controller.expenses.length}");
                            // for (var element in controller.expenses) {
                            //   print(element.category);
                            // }
                            var todayList = controller.expenseTodayList();
                            for (var element in todayList) {
                              print("Today$element");
                              print(element.values.first.date.toString());
                              print(element.keys.first.toString());
                            }
                            return ExpenseListTileComponent(
                                expense: todayList[index].values.first,
                                indexInBox: todayList[index].keys.first);
                          },
                        ),
                        fallbackBuilder: (context) => Text(
                          "Tidak ada data",
                          style: AppTextStyles.paragraphSemibold
                              .copyWith(color: AppColors.grey3),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Kemarin",
                        style: AppTextStyles.bigTitle
                            .copyWith(color: AppColors.grey1),
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            controller.expenseYesterdayList().isNotEmpty,
                        widgetBuilder: (context) => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.expenseYesterdayList().length,
                          itemBuilder: (context, index) {
                            // print("===expense====${controller.expenses.length}");
                            // for (var element in controller.expenses) {
                            //   print(element.category);
                            // }
                            var yesterdayList =
                                controller.expenseYesterdayList();
                            for (var element in yesterdayList) {
                              print("Today$element");
                              print(element.values.first.date.toString());
                              print(element.keys.first.toString());
                            }
                            return ExpenseListTileComponent(
                                expense: yesterdayList[index].values.first,
                                indexInBox: yesterdayList[index].keys.first);
                          },
                        ),
                        fallbackBuilder: (context) => Text(
                          "Tidak ada data",
                          style: AppTextStyles.paragraphSemibold
                              .copyWith(color: AppColors.grey3),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Yang lalu",
                        style: AppTextStyles.bigTitle
                            .copyWith(color: AppColors.grey1),
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            controller.expenseLongTimeAgo().isNotEmpty,
                        widgetBuilder: (context) => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.expenseLongTimeAgo().length,
                          itemBuilder: (context, index) {
                            var longTimeAgoList =
                                controller.expenseLongTimeAgo();
                            for (var element in longTimeAgoList) {
                              print("Today$element");
                              print(element.values.first.date.toString());
                              print(element.keys.first.toString());
                            }
                            return ExpenseListTileComponent(
                                expense: longTimeAgoList[index].values.first,
                                indexInBox: longTimeAgoList[index].keys.first);
                          },
                        ),
                        fallbackBuilder: (context) => Text(
                          "Tidak ada data",
                          style: AppTextStyles.paragraphSemibold
                              .copyWith(color: AppColors.grey3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.blue,
          onPressed: () {
            Get.toNamed(Routes.ADD_EXPENSE);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
