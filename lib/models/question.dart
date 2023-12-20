// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
    String? key;
    String? text;
    String? type;
    Range? range;
    List<Option>? options;

    Question({
        this.key,
        this.text,
        this.type,
        this.range,
        this.options,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        key: json["key"],
        text: json["text"],
        type: json["type"],
        range: json["range"] == null ? null : Range.fromJson(json["range"]),
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "text": text,
        "type": type,
        "range": range?.toJson(),
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    };
}

class Option {
    String? key;
    String? text;

    Option({
        this.key,
        this.text,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        key: json["key"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "text": text,
    };
}

class Range {
    int? min;
    int? max;
    int? step;

    Range({
        this.min,
        this.max,
        this.step,
    });

    factory Range.fromJson(Map<String, dynamic> json) => Range(
        min: json["min"],
        max: json["max"],
        step: json["step"],
    );

    Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
        "step": step,
    };
}
