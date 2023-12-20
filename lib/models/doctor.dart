// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

import 'package:winhealth_admin/models/user_model.dart';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  int? userId;
  String? license;
  int? experience;
  String? details;
  String? doctorType;
  UserModel? user;

  Doctor({
    this.userId,
    this.license,
    this.experience,
    this.details,
    this.doctorType,
    this.user,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        userId: json["user_id"],
        license: json["license"],
        experience: json["experience"],
        details: json["details"],
        doctorType: json["doctor_type"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "license": license,
        "experience": experience,
        "details": details,
        "doctor_type": doctorType,
        "user": user?.toJson(),
      };
}
