import 'package:devsociety/models/User.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserDTO? _userDTO;
  UserProvider() {}
  UserDTO get userDTO => _userDTO!;
  setUserInfo(UserDTO? user) {
    _userDTO = user;
    notifyListeners();
  }
}
