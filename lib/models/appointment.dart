// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

import 'package:winhealth_admin/models/notes.dart';
import 'package:winhealth_admin/models/slot.dart';
import 'package:winhealth_admin/models/user_model.dart';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(
    json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  String? slotId;
  String? status;
  List<Note>? notes;
  String? userId;
  String? id;
  UserModel? user;
  Slot? slot;

  Appointment({
    this.slotId,
    this.status,
    this.notes,
    this.userId,
    this.id,
    this.user,
    this.slot,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        slotId: json["slot_id"],
        status: json["status"],
        notes: json["notes"] == null
            ? []
            : List<Note>.from(
                jsonDecode(json["notes"]).map((x) => Note.fromJson(x))),
        userId: json["user_id"],
        id: json["id"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        slot: json["slot"] == null ? null : Slot.fromJson(json["slot"]),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "status": status,
        "notes": notes,
        "user_id": userId,
        "id": id,
        "user": user?.toJson(),
        "slot": slot?.toJson(),
      };
}
