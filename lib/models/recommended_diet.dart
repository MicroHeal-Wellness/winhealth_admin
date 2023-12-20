// To parse this JSON data, do
//
//     final recommendedDiet = recommendedDietFromJson(jsonString);

import 'dart:convert';

import 'package:winhealth_admin/models/diet.dart';

RecommendedDiet recommendedDietFromJson(String str) =>
    RecommendedDiet.fromJson(json.decode(str));

String recommendedDietToJson(RecommendedDiet data) =>
    json.encode(data.toJson());

class RecommendedDiet {
  List<Diet>? breakfast;
  List<Diet>? lunch;
  List<Diet>? dinner;

  RecommendedDiet({
    this.breakfast,
    this.lunch,
    this.dinner,
  });

  factory RecommendedDiet.fromJson(Map<String, dynamic> json) =>
      RecommendedDiet(
        breakfast: json["Breakfast"] == null
            ? []
            : List<Diet>.from(json["Breakfast"]!.map((x) => Diet.fromJson(x))),
        lunch: json["Lunch"] == null
            ? []
            : List<Diet>.from(json["Lunch"]!.map((x) => Diet.fromJson(x))),
        dinner: json["Dinner"] == null
            ? []
            : List<Diet>.from(json["Dinner"]!.map((x) => Diet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Breakfast": breakfast == null
            ? []
            : List<dynamic>.from(breakfast!.map((x) => x.toJson())),
        "Lunch": lunch == null
            ? []
            : List<dynamic>.from(lunch!.map((x) => x.toJson())),
        "Dinner": dinner == null
            ? []
            : List<dynamic>.from(dinner!.map((x) => x.toJson())),
      };
}
