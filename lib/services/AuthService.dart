import 'dart:convert';

import 'package:devsociety/models/User.dart';
import 'package:devsociety/utils/response.dart';
import 'package:devsociety/utils/variable.dart';
import 'package:http/http.dart' as http;

class AuthService {

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
        data: response.statusCode == 200
            ? UserDTO.fromJson(jsonDecode(response.body))
            : null,
      );
    } catch (e) {
      print(e);
      return Response();
    }
  }

  Future<Response> signup(User user, {String? type}) async {
    try {
      var response = await http.post(
        Uri.parse("${API.server}/auth/signup"),
        headers: API.headerContentType,
        body: json.encode({
          "firstName": user.firstname,
          "lastName": user.lastname,
          "email": user.email,
          "password": user.password,
          "avatar": user.avatar,
          "type": type
        }),
        
      );

      return Response(
        statusCode: response.body != "" ? response.statusCode : 409,
        data: response.statusCode == 200 && response.body != ""
            ? UserDTO.fromJson(jsonDecode(response.body))
            : null,
      );
    } catch (e) {
      print(e);
      return Response();
    }
  }
}
