// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
    List<Message> messages;

    Chat({
        required this.messages,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    int senderId;
    String content;
    Timestamp time;

    Message({
        required this.senderId,
        required this.content,
        required this.time,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        senderId: json["senderId"],
        content: json["content"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "content": content,
        "time": time,
    };
}
