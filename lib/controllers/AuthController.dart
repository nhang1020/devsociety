import 'dart:convert';

import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/ThemeProvider.dart';
import 'package:devsociety/services/AuthService.dart';
import 'package:devsociety/views/components/snackBar.dart';
import 'package:devsociety/views/index.dart';
import 'package:devsociety/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController {
  final BuildContext context;
  AuthController({required this.context});
  AuthService _authService = AuthService();

  Future<void> login(String userName, String password) async {
    try {
      var res = await _authService.login(userName, password);
      if (res.statusCode == 200) {
        UserDTO account = res.data;
        await _authService.saveLocalAccount(
          UserDTO(
              user: User(
                id: account.user.id,
                firstname: account.user.firstname,
                lastname: account.user.lastname,
                email: account.user.email,
              ),
              token: account.token,
              refreshToken: account.refreshToken),
        );
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Index(account: account),
          ),
        );
      } else if (res.statusCode == 403) {
        MySnackBar(context: context).showError("Invalid user name or password",
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode);
      } else {
        MySnackBar(context: context).showError("Server error",
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signup(User user) async {
    var res = await _authService.signup(user);
    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Text(jsonEncode(res.data)),
          ),
        ),
      );
    } else if (res.statusCode == 403) {
      MySnackBar(context: context).showError("Error",
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode);
    } else {
      MySnackBar(context: context).showError("Server error",
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode);
    }
  }

  Future<void> continueLogin() async {
    UserDTO? account = await AuthService().getLocalAccount();
    if (account != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Index(account: account),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }
}
