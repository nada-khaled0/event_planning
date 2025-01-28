import 'package:event_planning/model/my%20user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
