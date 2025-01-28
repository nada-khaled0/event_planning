import 'package:event_planning/utils/app%20colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle semi20Black = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle medium16White = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.whiteColor);
  static TextStyle medium20White = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.whiteColor);
  static TextStyle medium16Primary = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryLight);
  static TextStyle medium20Primary = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.primaryLight);
  static TextStyle medium16Grey = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.greyColor);
  static TextStyle medium16Black = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.blackColor);

  static TextStyle regular20White = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.normal, color: AppColors.whiteColor);
  static TextStyle regular14White = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.whiteColor);

  static TextStyle bold20Black = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blackColor);
  static TextStyle bold20Primary = GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryLight);
  static TextStyle bold16Primary = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryLight);
  static TextStyle bold12White = GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.whiteColor);
  static TextStyle bold24White = GoogleFonts.inter(
      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.whiteColor);
  static TextStyle bold14Primary = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryLight);
  static TextStyle bold14Black = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blackColor);
}
