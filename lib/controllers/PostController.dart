import 'dart:convert';

import 'package:devsociety/controllers/LocalPreference.dart';
import 'package:devsociety/models/Post.dart';
import 'package:devsociety/utils/variable.dart';
import 'package:http/http.dart' as http;

class PostController {
  Future<Post?> createPost(Post post) async {
    try {
      var response = await http.post(
        Uri.parse("${API.server}/post"),
        headers: API.headerContentTypes(LocalPreference.token),
        body: json.encode({
          "topic": post.topic,
          "title": post.title,
          "content": post.content,
          "userId": post.author
        }),
      );
      if (response.statusCode == 201) {
        Post post = Post.fromJson(jsonDecode(response.body));
        return post;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Post>> getPosts(int offset, int limit) async {
    List<Post> listPosts = [];
    try {
      var response = await http.get(
        Uri.parse("${API.server}/post/$offset/$limit"),
        headers: API.headerContentTypes(LocalPreference.token),
      );
      if (response.statusCode == 200) {
        listPosts = listPostFromJson(response.body);
      }

      return listPosts;
    } catch (e) {
      print("->$e");
      return listPosts;
    }
  }
}
