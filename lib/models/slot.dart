// To parse this JSON data, do
//
//     final slot = slotFromJson(jsonString);

import 'dart:convert';

List<Slot> slotFromJson(String str) => List<Slot>.from(json.decode(str).map((x) => Slot.fromJson(x)));

String slotToJson(List<Slot> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Slot {
    String? id;
    String? doctorId;
    String? startTime;
    int? duration;
    String? status;
    DateTime? date;
    String? day;

    Slot({
        this.id,
        this.doctorId,
        this.startTime,
        this.duration,
        this.status,
        this.date,
        this.day,
    });

    factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        doctorId: json["doctor_id"],
        startTime: json["start_time"],
        duration: json["duration"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId,
        "start_time": startTime,
        "duration": duration,
        "status": status,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "day": day,
    };
}
