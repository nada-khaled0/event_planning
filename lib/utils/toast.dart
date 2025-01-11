import 'package:event_planning/utils/app%20colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static Future<bool?> toastMsg({required String msg}) {
    return Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        fontSize: 16.0);
  }
}
