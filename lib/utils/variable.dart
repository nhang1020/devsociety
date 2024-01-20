class API {
  static final String server = "http://26.132.7.161:8080/api/v1";
  static Map<String, String> headerContentType = {
    "Content-Type": "application/json"
  };
  static Map<String, String> headerAuthorize(String token) =>
      {'Authorization': 'Bearer $token'};
}
