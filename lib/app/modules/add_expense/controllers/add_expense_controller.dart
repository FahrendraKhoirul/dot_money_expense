import 'package:dot_money_expense/app/constants/app_colors.dart';
import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:dot_money_expense/app/constants/category_item.dart';
import 'package:dot_money_expense/app/data/models/expense_model.dart';
import 'package:dot_money_expense/app/data/repositories/expense_repository.dart';
import 'package:dot_money_expense/app/modules/add_expense/views/component/category_item_component.dart';
import 'package:dot_money_expense/app/modules/home/controllers/home_controller.dart';
import 'package:dot_money_expense/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpenseController extends GetxController {
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TextEditingController> nominalController = TextEditingController().obs;
  Rx<TextEditingController> categoryController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  RxList categoryListKey = [
    "makanan",
    "internet",
    "edukasi",
    "hadiah",
    "transportasi",
    "belanja",
    "alat_rumah",
    "olahraga",
    "hiburan"
  ].obs;
  RxString selectedCategory = "makanan".obs;

  final formKey = GlobalKey<FormState>();

  int? argIndexInBox = Get.arguments?["id"];
  ExpenseModel? argExpense = Get.arguments?["expense"];

  @override
  // initialize the controller
  void onInit() {
    super.onInit();
    dateController.value.text =
        DateFormat("EEEE, d MMMM yyyy", "id_ID").format(selectedDate.value);
    categoryController.value.text =
        CategoryItem.category[categoryListKey[0]]["title"];

    if (argExpense != null) {
      nameController.value.text = argExpense!.name!;
      dateController.value.text =
          DateFormat("EEEE, d MMMM yyyy", "id_ID").format(argExpense!.date!);
      nominalController.value.text = argExpense!.nominal.toString();
      selectedCategory.value = argExpense!.category!;
      selectedDate.value = argExpense!.date!;
    }
  }

  @override
  void onClose() {
    dateController.value.dispose();
    super.onClose();
  }

  Future<void> selectCategory(BuildContext context) async {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), // Adjust radius as needed
            topRight: Radius.circular(20.0), // Adjust radius as needed
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pilih Kategori",
                      style: AppTextStyles.bigTitle
                          .copyWith(color: AppColors.grey1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryListKey.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        categoryController.value.text = CategoryItem
                            .category[categoryListKey[index]]["title"];
                        selectedCategory.value = categoryListKey[index];
                        Get.back();
                      },
                      child: CategoryItemComponent(
                        iconPath: CategoryItem.category[categoryListKey[index]]
                            ["icon_path"],
                        title: CategoryItem.category[categoryListKey[index]]
                            ["title"],
                        color: CategoryItem.category[categoryListKey[index]]
                            ["color"],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      isDismissible: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dateController.value.text =
          DateFormat("EEEE, d MMMM yyyy", "id_ID").format(pickedDate);
      // print(dateController.value.text);
    }
  }

  void submitButton() {
    if (formKey.currentState!.validate()) {
      if (argExpense != null) {
        updateExpense();
      } else {
        saveExpense();
      }
    }
  }

  Future<void> saveExpense() async {
    if (formKey.currentState!.validate()) {
      // print("-====== HALO====${nominalController.value.text}");
      ExpenseRepository.insertExpense(
        nameController.value.text,
        selectedCategory.value,
        selectedDate.value,
        int.parse(nominalController.value.text),
      );
      // ExpenseRepository.getAllExpenses().then((value) => print(value));
      Get.offNamedUntil(Routes.HOME, (route) => false);
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Pengeluaran berhasil ditambahkan!',
          snackStyle: SnackStyle.GROUNDED,
          duration: Duration(seconds: 4),
          backgroundColor: Colors.green, // Optional: Customize background color
        ),
      );
      clearForm();
      HomeController.to.fetchExpenses();
    }
  }

  Future<void> deleteExpense() async {
    ExpenseRepository.deleteExpense(argIndexInBox!);
    Get.offNamedUntil(Routes.HOME, (route) => false);
    Get.showSnackbar(
      const GetSnackBar(
          message: 'Pengeluaran berhasil dihapus!',
          snackStyle: SnackStyle.GROUNDED,
          duration: Duration(seconds: 4),
          backgroundColor: Colors.green // Optional: Customize background color
          ),
    );
    HomeController.to.fetchExpenses();
  }

  Future<void> updateExpense() async {
    ExpenseRepository.updateExpense(
        argIndexInBox!,
        ExpenseModel(
          name: nameController.value.text,
          category: selectedCategory.value,
          date: selectedDate.value,
          nominal: int.parse(nominalController.value.text),
        ));
    Get.offNamedUntil(Routes.HOME, (route) => false);
    Get.showSnackbar(
      const GetSnackBar(
          message: 'Pengeluaran berhasil diupdate!',
          snackStyle: SnackStyle.GROUNDED,
          duration: Duration(seconds: 4),
          backgroundColor: Colors.green // Optional: Customize background color
          ),
    );
    HomeController.to.fetchExpenses();
  }

  void clearForm() {
    dateController.value.clear();
    nominalController.value.clear();
    categoryController.value.clear();
    nameController.value.clear();
  }
}
