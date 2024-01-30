import 'dart:convert';

import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreference {
  static String token = "";
  Future<void> saveLocalAccount(BuildContext context,UserDTO account) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("account", '${jsonEncode(account)}');
      token = await account.token;
      Provider.of<UserProvider>(context, listen: false).setUserInfo(account);
    } catch (e) {
      print(e);
    }
  }

  Future<UserDTO?> getLocalAccount(BuildContext context) async {
    UserDTO? account;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = await prefs.getString("account");
      account = UserDTOFromJson(data!);
      token = account.token;
      Provider.of<UserProvider>(context, listen: false).setUserInfo(account);
    } catch (e) {
      return null;
    }
    return account;
  }

  Future<void> clearLocal({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (key != null) {
      prefs.remove(key);
      if (key == 'account') UserProvider().setUserInfo(null);
    } else {
      prefs.clear();
    }
  }
}
