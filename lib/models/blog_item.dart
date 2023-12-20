// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

import 'package:winhealth_admin/models/user_model.dart';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  String? id;
  String? userId;
  String? title;
  String? content;
  String? cover;
  String? author;
  UserModel? user;

  Blog({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.cover,
    this.author,
    this.user,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        content: json["content"],
        cover: json["cover"],
        author: json["author"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "content": content,
        "cover": cover,
        "author": author,
        "user": user?.toJson(),
      };
}
