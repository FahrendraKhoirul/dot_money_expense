import 'package:dot_money_expense/app/constants/app_colors.dart';
import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:dot_money_expense/app/constants/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../controllers/add_expense_controller.dart';

class AddExpenseView extends GetView<AddExpenseController> {
  const AddExpenseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Tambah Pengeluaran Baru',
            style: AppTextStyles.bigTitle.copyWith(color: AppColors.grey1),
          ),
          // leading: Icon(icon),
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              color: AppColors.grey1,
              size: 40,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            controller.argExpense != null
                ? IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      controller.deleteExpense();
                    },
                  )
                : Container(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Pengeluaran tidak boleh kosong';
                    }
                    return null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  style: AppTextStyles.paragraphSemibold,
                  decoration: InputDecoration(
                    hintText: 'Nama Pengeluaran',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    focusColor: AppColors.blue,
                    hintStyle: AppTextStyles.paragraphMedium,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => TextField(
                    controller: controller.categoryController.value,
                    style: AppTextStyles.paragraphSemibold,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        CategoryItem.category[controller.selectedCategory.value]
                            ["icon_path"],
                        color: CategoryItem
                                .category[controller.selectedCategory.value]
                            ["color"],
                      ),
                      suffixIcon: IconButton(
                        icon: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.grey5,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_right_rounded,
                              color: AppColors.grey3),
                        ),
                        onPressed: () {
                          controller.selectCategory(context);
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      controller.selectCategory(context);
                    },
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: controller.dateController.value,
                  style: AppTextStyles.paragraphSemibold,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        controller.selectDate(context);
                      },
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    controller.selectDate(context);
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: controller.nominalController.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nominal tidak boleh kosong';
                    }

                    return null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  style: AppTextStyles.paragraphSemibold,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Nominal',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    focusColor: AppColors.blue,
                    hintStyle: AppTextStyles.paragraphMedium,
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                // button
                ElevatedButton(
                  onPressed: () {
                    controller.submitButton();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 0.0.h),
                    backgroundColor: AppColors.blue,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
                    textStyle: AppTextStyles.bigTitle,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
