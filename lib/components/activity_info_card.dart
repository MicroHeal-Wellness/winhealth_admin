import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:winhealth_admin/components/food_item_info_card.dart';
import 'package:winhealth_admin/models/activity.dart';
import 'package:winhealth_admin/models/food_item.dart';

List<String> moodTypes = [
  "Happy, relaxed, calm, content",
  "Okay, well enough, passable",
  "Sad, upset, depressed",
  "Anxious, worried, fearful",
  "Disgusted, tired",
  "Angry, annoyed, tense, irritable",
];
List<String> sleepQualityTypes = [
  "Awful",
  "Bad",
  "Not bad",
  "Good",
  "Great",
];

List<String> constipationTypes = [
  "None",
  "Not very severe",
  "Quite severe",
  "Severe",
  "Extremely severe",
];

List<String> bloatedTypes = [
  "None",
  "Not very severe",
  "Quite severe",
  "Severe",
  "Extremely severe",
];

List<String> diarrheaTypes = [
  "None",
  "Not very severe",
  "Quite severe",
  "Severe",
  "Extremely severe",
];

List<String> painTypes = [
  "None",
  "Noticeable discomfort",
  "Tolerable pain",
  "In a lot of pain",
  "Extreme pain",
];

class ActivityInfoCard extends StatelessWidget {
  final ActivityItem activityItem;
  const ActivityInfoCard({super.key, required this.activityItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activity: ${activityItem.activityType}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            mapper(
              activityItem.activityType,
            )
          ],
        ),
      ),
    );
  }

  mapper(name) {
    switch (name) {
      case "stress":
        return activityItem.response == null
            ? const Text("No Data")
            : Text(
                "Mood: ${moodTypes[activityItem.response.mood]}",
                style: const TextStyle(fontSize: 18),
              );
      case "water":
        return activityItem.response == null
            ? const Text("No Data")
            : Text(
                "Amount: ${activityItem.response.quantity} L",
                style: const TextStyle(fontSize: 18),
              );
      case "sleep":
        return activityItem.response == null
            ? const Text("No Data")
            : Text(
                "Duration: ${activityItem.response.duration} Hrs, Quality: ${sleepQualityTypes[activityItem.response.quality]}",
                style: const TextStyle(fontSize: 18),
              );
      case "stool":
        return activityItem.response == null
            ? const Text("No Data")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Text(
                        "Frequency: ${activityItem.response.frequency}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Text(
                        "Form: ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ] +
                    activityItem.response.formOfStoolTypes
                        .map<Text>((e) => Text(
                              "${e['name']}: ${e['count']}",
                              style: const TextStyle(fontSize: 18),
                            ))
                        .toList(),
              );
      case "food":
        return activityItem.response == null
            ? const Text("No Data")
            :
            // Text(activityItem.response.breakfast);
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: activityItem.response.breakfast
                        .map<Widget>((food) => FoodItemInfoCard(
                              foodItem: food,
                            ))
                        .toList() +
                    activityItem.response.lunch
                        .map<Widget>((food) => FoodItemInfoCard(
                              foodItem: food,
                            ))
                        .toList() +
                    activityItem.response.dinner
                        .map<Widget>((food) => FoodItemInfoCard(
                              foodItem: food,
                            ))
                        .toList() +
                    activityItem.response.others
                        .map<Widget>((food) => FoodItemInfoCard(
                              foodItem: food,
                            ))
                        .toList(),
              );
      case "digestion":
        return activityItem.response == null
            ? const Text("No Data")
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Constipation: ${constipationTypes[activityItem.response.constipation]}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Bloated: ${bloatedTypes[activityItem.response.bloated]}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Diarrhea: ${diarrheaTypes[activityItem.response.diarrhea]}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Pain: ${painTypes[activityItem.response.pain]}",
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              );
      default:
        return const Text("No Data");
    }
  }
}
