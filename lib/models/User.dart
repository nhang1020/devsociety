// To parse this JSON data, do
//
//     final UserDTO = UserDTOFromJson(jsonString);

import 'dart:convert';

UserDTO UserDTOFromJson(String str) => UserDTO.fromJson(json.decode(str));

String UserDTOToJson(UserDTO data) => json.encode(data.toJson());
User userFromJson(String str) => User.fromJson(json.decode(str));

class UserDTO {
  User user;
  String token;
  String refreshToken;

  UserDTO({
    required this.user,
    required this.token,
    required this.refreshToken,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        user: User.fromJson(json["user"]),
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "refreshToken": refreshToken,
      };
}

class User {
  dynamic id;
  dynamic firstname;
  dynamic lastname;
  dynamic email;
  dynamic password;
  dynamic avatar;
  dynamic role;
  dynamic type;
  User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.password,
    this.avatar,
    this.role,
    this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
        role: json["role"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "avatar": avatar,
        "role": role,
        "type": type,
      };
}
