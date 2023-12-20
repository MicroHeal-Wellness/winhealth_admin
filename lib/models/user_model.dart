// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? id;
    String? firstName;
    String? lastName;
    DateTime? dob;
    String? gender;
    String? emailId;
    bool? emailVerified;
    String? userType;
    String? status;
    String? phone;

    UserModel({
        this.id,
        this.firstName,
        this.lastName,
        this.dob,
        this.gender,
        this.emailId,
        this.emailVerified,
        this.userType,
        this.status,
        this.phone,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"] ?? "Male",
        emailId: json["email_id"],
        emailVerified: json["email_verified"],
        userType: json["user_type"],
        status: json["status"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "email_id": emailId,
        "email_verified": emailVerified,
        "user_type": userType,
        "status": status,
        "phone": phone,
    };
}
