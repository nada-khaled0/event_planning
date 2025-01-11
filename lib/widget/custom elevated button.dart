import 'package:flutter/material.dart';

import '../utils/app colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/app styles.dart';

class CustomElevatedButton extends StatelessWidget {
  String text;
  Widget? icon;
  Color? backgroundColor;
  TextStyle? textStyle;
  Function onButtonClicked;

  CustomElevatedButton(
      {required this.text,
      this.icon,
      this.backgroundColor,
      this.textStyle,
      required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primaryLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.primaryLight, width: 1)),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.02)),
        onPressed: () {
          onButtonClicked();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox(),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              text,
              style: textStyle ?? AppStyles.medium20White,
            )
          ],
        ));
  }
}
