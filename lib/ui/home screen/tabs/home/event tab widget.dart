import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:flutter/material.dart';

class EventTabWidget extends StatelessWidget {
  String eventName;
  bool isSelected;
  Color backgroundColor;
  TextStyle selectedTextStyle;
  TextStyle unselectedTextStyle;
  Color? borderColor;

  EventTabWidget(
      {required this.eventName,
      required this.isSelected,
      required this.backgroundColor,
      required this.selectedTextStyle,
      required this.unselectedTextStyle,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.005),
      decoration: BoxDecoration(
          color: isSelected ? backgroundColor : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: borderColor ?? AppColors.whiteColor, width: 2)),
      child: Text(
        eventName,
        style: isSelected ? selectedTextStyle : unselectedTextStyle,
      ),
    );
  }
}
