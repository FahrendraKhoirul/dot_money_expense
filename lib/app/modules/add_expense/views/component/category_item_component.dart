import 'package:dot_money_expense/app/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemComponent extends StatelessWidget {
  const CategoryItemComponent(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.color});
  // create 2 parameter for path icon and title
  final String iconPath;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          padding: EdgeInsets.all(7.h),
          child: Image.asset(
            iconPath,
            height: 36.h,
            width: 36.w,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(title, style: AppTextStyles.captionMedium),
      ],
    );
  }
}
