// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  String? message;
  String? sender;

  Message({
    this.message,
    this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"],
        sender: json["sender"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sender": sender,
      };
}
