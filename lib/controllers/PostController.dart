import 'dart:convert';

import 'package:devsociety/controllers/LocalPreference.dart';
import 'package:devsociety/models/Post.dart';
import 'package:devsociety/utils/variable.dart';
import 'package:http/http.dart' as http;

class PostController {
  Future<void> createPost(Post post) async {
    try {
      var response = await http.post(
        Uri.parse("${API.server}/post"),
        headers: API.headerContentTypes(LocalPreference.token),
        body: json.encode({
          "topic": post.topic,
          "title": post.title,
          "content": post.content,
          "user_id": post.userId
        }),
      );
      print(response.statusCode);
      print(LocalPreference.token);
    } catch (e) {
      print(e);
    }
  }
}
