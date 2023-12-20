// To parse this JSON data, do
//
//     final diet = dietFromJson(jsonString);

import 'dart:convert';

Diet dietFromJson(String str) => Diet.fromJson(json.decode(str));

String dietToJson(Diet data) => json.encode(data.toJson());

class Diet {
  List<String>? ingredients;
  String? name;
  List<String>? instruction;
  int? cookTime;
  String? id;
  String? course;
  String? diet;
  int? prepTime;
  int? servings;
  String? description;
  String? imgLink;

  Diet({
    this.ingredients,
    this.name,
    this.instruction,
    this.cookTime,
    this.id,
    this.course,
    this.diet,
    this.prepTime,
    this.servings,
    this.description,
    this.imgLink,
  });

  factory Diet.fromJson(Map<String, dynamic> json) => Diet(
        ingredients: json["ingredients"] == null
            ? []
            : List<String>.from(json["ingredients"]!.map((x) => x)),
        name: json["name"],
        instruction: json["instruction"] == null
            ? []
            : List<String>.from(json["instruction"]!.map((x) => x)),
        cookTime: json["cook_time"],
        id: json["id"],
        course: json["course"],
        diet: json["diet"],
        prepTime: json["prep_time"],
        servings: json["servings"],
        description: json["description"],
        imgLink: json["img_link"],
      );

  Map<String, dynamic> toJson() => {
        "ingredients": ingredients == null
            ? []
            : List<dynamic>.from(ingredients!.map((x) => x)),
        "name": name,
        "instruction": instruction == null
            ? []
            : List<dynamic>.from(instruction!.map((x) => x)),
        "cook_time": cookTime,
        "id": id,
        "course": course,
        "diet": diet,
        "prep_time": prepTime,
        "servings": servings,
        "description": description,
        "img_link": imgLink,
      };
}
