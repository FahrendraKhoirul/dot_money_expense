import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle bigTitle = GoogleFonts.sourceSans3(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle paragraphBold = GoogleFonts.sourceSans3(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle paragraphSemibold = GoogleFonts.sourceSans3(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle paragraphMedium = GoogleFonts.sourceSans3(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle captionMedium = GoogleFonts.sourceSans3(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle captionBold = GoogleFonts.sourceSans3(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
}
