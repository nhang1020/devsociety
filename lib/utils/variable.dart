import 'package:devsociety/controllers/LocalPreference.dart';

class API {
  static final String server = "http://26.132.7.161:8080/api/v1";
  static Map<String, String> headerContentType = {
    "Content-Type": "application/json"
  };
  static Map<String, String> headerContentTypes(String token) => {
        "Content-Type": "application/json;charset=UTF-8",
        'Authorization': 'Bearer $token'
      };
  static Map<String, String> headerAuthorize(String token) =>
      {'Authorization': 'Bearer $token'};
}
