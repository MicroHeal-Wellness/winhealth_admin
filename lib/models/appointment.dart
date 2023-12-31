// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';
import 'package:winhealth_admin/models/slot.dart';
import 'package:winhealth_admin/models/user_model.dart';

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
    String? id;
    UserModel? userCreated;
    DateTime? dateCreated;
    String? cancelledBy;
    bool? completed;
    Slot? slot;

    Appointment({
        this.id,
        this.userCreated,
        this.dateCreated,
        this.cancelledBy,
        this.completed,
        this.slot,
    });

    factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        userCreated: UserModel.fromJson(json["user_created"]),
        dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
        cancelledBy: json["cancelled_by"],
        completed: json["completed"],
        slot: json["slot"] == null ? null : Slot.fromJson(json["slot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_created": userCreated?.toJson(),
        "date_created": dateCreated?.toIso8601String(),
        "cancelled_by": cancelledBy,
        "completed": completed,
        "slot": slot?.toJson(),
    };
}