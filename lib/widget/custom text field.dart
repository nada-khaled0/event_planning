import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Color? borderColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  int? maxLines;
  TextInputType? keyboard;
  String? Function(String?)? validator;
  TextEditingController? controller;

  CustomTextField(
      {this.borderColor,
      required this.hintText,
      this.labelText,
      this.hintStyle,
      this.labelStyle,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.maxLines,
      this.validator,
      this.controller,
      this.keyboard = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      validator: validator,
      maxLines: maxLines ?? 1,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.medium16Grey,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyles.medium16Grey,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: borderColor ?? AppColors.greyColor, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: borderColor ?? AppColors.greyColor, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.redColor, width: 2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.redColor, width: 2)),
      ),
    );
  }
}
