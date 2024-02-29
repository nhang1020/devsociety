import 'package:devsociety/controllers/LocalPreference.dart';
import 'package:devsociety/models/User.dart';
import 'package:devsociety/utils/variable.dart';
import 'package:http/http.dart' as http;

class UserController {
  Future<List<User>> getAllUsers(int id) async {
    List<User> listUsers = [];
    try {
      var response = await http.get(
        Uri.parse("${API.server}/user/all/$id"),
        headers: API.headerContentTypes(LocalPreference.token),
      );
      if (response.statusCode == 200) {
        listUsers = listUserFromJson(response.body);
      }
      return listUsers;
    } catch (e) {
      print("->$e");
      return listUsers;
    }
  }
}
