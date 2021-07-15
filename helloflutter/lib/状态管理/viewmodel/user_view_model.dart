import '../model/user_info.dart';
import 'package:flutter/material.dart';

class HYUserViewModel extends ChangeNotifier {
  UserInfo _user;
  HYUserViewModel(this._user);
  UserInfo get user => _user;
  set user(UserInfo value) {
    _user = value;
    notifyListeners();
  }
}