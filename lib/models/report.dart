// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

import 'package:winhealth_admin/models/user_model.dart';

List<Report> reportFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String reportToJson(List<Report> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
  String? id;
  String? url;
  String? type;
  String? key;
  String? userId;
  DateTime? createdAt;
  UserModel? user;

  Report({
    this.id,
    this.url,
    this.type,
    this.key,
    this.userId,
    this.createdAt,
    this.user,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        url: json["url"],
        type: json["type"],
        key: json["key"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
        "key": key,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}
