// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

import 'package:winhealth_admin/models/user_model.dart';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  String? height;
  String? weight;
  bool? isPregnant;
  String? diet;
  int? userId;
  UserModel? user;

  Patient({
    this.height,
    this.weight,
    this.isPregnant,
    this.diet,
    this.userId,
    this.user,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        height: json["height"],
        weight: json["weight"],
        isPregnant: json["is_pregnant"],
        diet: json["diet"],
        userId: json["user_id"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "weight": weight,
        "is_pregnant": isPregnant,
        "diet": diet,
        "user_id": userId,
        "user": user?.toJson(),
      };
}
