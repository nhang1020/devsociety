import 'dart:convert';

import 'package:devsociety/models/User.dart';
import 'package:devsociety/utils/response.dart';
import 'package:devsociety/utils/variable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> saveLocalAccount(UserDTO account) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("account", '${jsonEncode(account)}');
    } catch (e) {
      print(e);
    }
  }

  Future<UserDTO?> getLocalAccount() async {
    UserDTO? account;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = prefs.getString("account");
      account = UserDTOFromJson(data!);
    } catch (e) {
      return null;
    }
    return account;
  }

  Future<Response> login(String userName, String password) async {
    try {
      var response = await http.post(
        Uri.parse("${API.server}/auth/signin"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": userName,
          "password": password,
        }),
      );

      return Response(
        statusCode: response.statusCode,
        data: response.statusCode == 403
            ? null
            : UserDTO.fromJson(jsonDecode(response.body)),
      );
    } catch (e) {
      print(e);
      return Response();
    }
  }

  Future<Response> signup(User user) async {
    try {
      var response = await http.post(
        Uri.parse("${API.server}/auth/signup"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "firstName": user.firstname,
          "lastName": user.lastname,
          "email": user.email,
          "password": user.password,
        }),
      );

      return Response(
        statusCode: response.statusCode,
        data: response.statusCode == 403
            ? null
            : UserDTO.fromJson(jsonDecode(response.body)).user,
      );
    } catch (e) {
      print(e);
      return Response();
    }
  }
}
