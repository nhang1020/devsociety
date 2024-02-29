import 'package:devsociety/controllers/UserController.dart';
import 'package:devsociety/models/User.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserDTO? _userDTO;
  List<User> _list = [];

  UserProvider() {
    // setListUser();
  }
  UserDTO get userDTO => _userDTO!;
  List<User> get listUsers => _list;

  Future<void> setListUser(int id) async {
    UserController userController = UserController();
    _list = await userController.getAllUsers(id);
    notifyListeners();
  }

  setUserInfo(UserDTO? user) {
    _userDTO = user;
    notifyListeners();
  }
}
