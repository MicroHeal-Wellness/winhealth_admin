// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

// ActivityItem activityItemFromJson(String str) =>
//     ActivityItem.fromJson(json.decode(str));

// String activityItemToJson(ActivityItem data) => json.encode(data.toJson());

class ActivityItem {
  final String name;
  final String date;
  dynamic value;

  ActivityItem({
    required this.name,
    required this.date,
    required this.value,
  });

  factory ActivityItem.fromJson(
          Map<String, dynamic>? json, String name, String date) =>
      ActivityItem(date: date, name: name, value: mapper(name, json));

//   Map<String, dynamic> toJson() => {
//         "stress": stress?.toJson(),
//         "water": water?.toJson(),
//         "sleep": sleep?.toJson(),
//         "stool": stool?.toJson(),
//         "food": food?.toJson(),
//         "digestion": digestion?.toJson(),
//       };
}

mapper(name, json) {
  switch (name) {
    case "stress":
      return json == null ? null : StressActivity.fromJson(json);
    case "water":
      return json == null ? null : WaterActivity.fromJson(json);
    case "sleep":
      return json == null ? null : SleepActivity.fromJson(json);
    case "stool":
      return json == null ? null : StoolActivity.fromJson(json);
    case "food":
      return json == null ? null : FoodActivity.fromJson(json);
    case "digestion":
      return json == null ? null : DigestionActivity.fromJson(json);
    default:
      return null;
  }
}

class DigestionActivity {
  int? constipation;
  int? bloated;
  int? diarrhea;
  int? pain;

  DigestionActivity({
    this.constipation,
    this.bloated,
    this.diarrhea,
    this.pain,
  });

  factory DigestionActivity.fromJson(Map<String, dynamic> json) =>
      DigestionActivity(
        constipation: json["constipation"],
        bloated: json["bloated"],
        diarrhea: json["diarrhea"],
        pain: json["pain"],
      );

  Map<String, dynamic> toJson() => {
        "constipation": constipation,
        "bloated": bloated,
        "diarrhea": diarrhea,
        "pain": pain,
      };
}

class FoodActivity {
  List<String>? breakfast;
  dynamic lunch;
  dynamic dinner;
  dynamic others;

  FoodActivity({
    this.breakfast,
    this.lunch,
    this.dinner,
    this.others,
  });

  factory FoodActivity.fromJson(Map<String, dynamic> json) => FoodActivity(
        breakfast: json["breakfast"] == null
            ? []
            : List<String>.from(json["breakfast"]!.map((x) => x)),
        lunch: json["lunch"],
        dinner: json["dinner"],
        others: json["others"],
      );

  Map<String, dynamic> toJson() => {
        "breakfast": breakfast == null
            ? []
            : List<dynamic>.from(breakfast!.map((x) => x)),
        "lunch": lunch,
        "dinner": dinner,
        "others": others,
      };
}

class SleepActivity {
  int? duration;
  int? quality;

  SleepActivity({
    this.duration,
    this.quality,
  });

  factory SleepActivity.fromJson(Map<String, dynamic> json) => SleepActivity(
        duration: json["duration"],
        quality: json["quality"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "quality": quality,
      };
}

class StoolActivity {
  int? frequency;
  int? form;
  dynamic formOfStoolTypes;

  StoolActivity({
    this.frequency,
    this.form,
    this.formOfStoolTypes
  });

  factory StoolActivity.fromJson(Map<String, dynamic> json) => StoolActivity(
        frequency: json["frequency"],
        form: json["form"],
        formOfStoolTypes:  json["formOfStoolTypes"]
      );

  Map<String, dynamic> toJson() => {
        "frequency": frequency,
        "form": form,
        "formOfStoolTypes": formOfStoolTypes
      };
}

class StressActivity {
  int? mood;

  StressActivity({
    this.mood,
  });

  factory StressActivity.fromJson(Map<String, dynamic> json) {
    return StressActivity(
      mood: json["mood"],
    );
  }

  Map<String, dynamic> toJson() => {
        "mood": mood,
      };
}

class WaterActivity {
  int? quantity;

  WaterActivity({
    this.quantity,
  });

  factory WaterActivity.fromJson(Map<String, dynamic> json) => WaterActivity(
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
      };
}
