// To parse this JSON data, do
//
//     final communityPost = communityPostFromJson(jsonString);

import 'dart:convert';

import 'package:winhealth_admin/models/user_model.dart';

CommunityPost communityPostFromJson(String str) =>
    CommunityPost.fromJson(json.decode(str));

String communityPostToJson(CommunityPost data) => json.encode(data.toJson());

class CommunityPost {
  String? id;
  String? userId;
  String? post;
  bool? deleted;
  UserModel? user;

  CommunityPost({
    this.id,
    this.userId,
    this.post,
    this.deleted,
    this.user,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
        id: json["id"],
        userId: json["user_id"],
        post: json["post"],
        deleted: json["deleted"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post": post,
        "deleted": deleted,
        "user": user?.toJson(),
      };
}
