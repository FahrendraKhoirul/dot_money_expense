import 'package:dot_money_expense/app/constants/app_colors.dart';
import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:dot_money_expense/app/constants/category_item.dart';
import 'package:dot_money_expense/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseByCategory extends GetView<HomeController> {
  const ExpenseByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Obx(
        () => Conditional.single(
          conditionBuilder: (context) => controller.totalByCategory.isNotEmpty,
          context: context,
          fallbackBuilder: (context) => const CircularProgressIndicator(
            color: AppColors.grey5,
          ),
          widgetBuilder: (context) => ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.totalByCategory.length - 1,
            itemBuilder: (context, index) {
              return Container(
                width: 120.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                margin: EdgeInsets.fromLTRB(20.w, 20.h, 0.w, 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.08),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: Offset(0.h, 4.w), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CategoryItem.category[controller
                            .totalByCategory.keys
                            .elementAt(index)]['color'],
                      ),
                      padding: EdgeInsets.all(7.h),
                      child: Image.asset(
                        CategoryItem.category[controller.totalByCategory.keys
                            .elementAt(index)]['icon_path'],
                        height: 36.h,
                        width: 36.w,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                        CategoryItem.category[controller.totalByCategory.keys
                            .elementAt(index)]['title'],
                        style: AppTextStyles.captionMedium),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                        "Rp. ${controller.totalByCategory[controller.totalByCategory.keys.elementAt(index)].toString()}",
                        style: AppTextStyles.captionBold),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
