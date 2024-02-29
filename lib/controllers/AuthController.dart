import 'dart:convert';

import 'package:devsociety/controllers/FirebaseController.dart';
import 'package:devsociety/controllers/LocalPreference.dart';
import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/ThemeProvider.dart';
import 'package:devsociety/services/AuthService.dart';
import 'package:devsociety/views/components/snackBar.dart';
import 'package:devsociety/views/index.dart';
import 'package:devsociety/views/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthController {
  final BuildContext context;
  AuthController({required this.context});
  AuthService _authService = AuthService();
  LocalPreference _localPreference = LocalPreference();
  Future<void> login(String userName, String password) async {
    try {
      var res = await _authService.login(userName, password);
      if (res.statusCode == 200) {
        UserDTO account = res.data;
        await _localPreference.saveLocalAccount(
          context,
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
            builder: (context) => Index(),
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
    print(res.statusCode);
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
    } else if (res.statusCode == 409) {
      MySnackBar(context: context).showError(
          "This email address already exists",
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode);
    } else {
      MySnackBar(context: context).showError("Server error",
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode);
    }
  }

  Future googleLogin() async {
    final googleUser = await GoogleSignIn(scopes: ['email']).signIn();
    if (googleUser == null) return;
    final googleAuth = await googleUser.authentication;

    final credential = fba.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await fba.FirebaseAuth.instance.signInWithCredential(credential);

    var res = await _authService.signup(
        User(
          firstname: googleUser.displayName ?? "",
          lastname: "",
          email: googleUser.email,
          avatar: googleUser.photoUrl,
          password: "",
        ),
        type: "SOCIAL");
    if (res.statusCode == 200) {
      UserDTO account = res.data;
      await _localPreference.saveLocalAccount(
        context,
        UserDTO(
            user: User(
              id: account.user.id,
              firstname: account.user.firstname,
              lastname: account.user.lastname,
              email: account.user.email,
              avatar: account.user.avatar,
            ),
            token: account.token,
            refreshToken: account.refreshToken),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Index(),
        ),
      );
    } else {
      MySnackBar(context: context).showError("Server error",
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode);
    }
  }

  Future googleLogout() async {
    await FirebaseController.changeStatusUser(false);
    await GoogleSignIn().signOut();
    await LocalPreference().clearLocal(key: 'account');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  Future<void> continueLogin() async {
    UserDTO? account = await _localPreference.getLocalAccount(context);
    if (account != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Index(),
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
