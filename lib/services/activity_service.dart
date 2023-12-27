import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:winhealth_admin/models/activity.dart';
import 'package:winhealth_admin/models/activity_stat.dart';
import 'package:winhealth_admin/services/base_service.dart';

class ActivityService {
  static Future<List<ActivityItem>> getActivitiesByUserIDandDate(
      String userID, String date) async {
    final response = await BaseService.makeAuthenticatedRequest(
      '${BaseService.BASE_URL}/items/activity_log?filter={"_and":[{"user_created":"$userID"},{"date":{"_eq":"$date"}}]}',
      method: 'GET',
    );
    List<ActivityItem> activityItemList = [];
    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      try {
        for (var element in responseMap['data']) {
          ActivityItem activityItem = ActivityItem.fromJson(element);
          activityItemList.add(activityItem);
        }
        if (activityItemList.isEmpty || activityItemList.length < 6) {
          var data = [];
          if (activityItemList
              .where(
                  (ActivityItem element) => (element.activityType == "water"))
              .isEmpty) {
            data.add({"activity_type": "water"});
          }
          if (activityItemList
              .where(
                  (ActivityItem element) => (element.activityType == "stool"))
              .isEmpty) {
            data.add({"activity_type": "stool"});
          }
          if (activityItemList
              .where(
                  (ActivityItem element) => (element.activityType == "stress"))
              .isEmpty) {
            data.add({"activity_type": "stress"});
          }
          if (activityItemList
              .where((ActivityItem element) => (element.activityType == "food"))
              .isEmpty) {
            data.add({"activity_type": "food"});
          }
          if (activityItemList
              .where(
                  (ActivityItem element) => (element.activityType == "sleep"))
              .isEmpty) {
            data.add({"activity_type": "sleep"});
          }
          if (activityItemList
              .where((ActivityItem element) =>
                  (element.activityType == "digestion"))
              .isEmpty) {
            data.add({"activity_type": "digestion"});
          }
          for (var element in data) {
            ActivityItem activityItem = ActivityItem.fromJson(element);
            activityItemList.add(activityItem);
          }
        }
        return activityItemList;
      } catch (e) {
        if (kDebugMode) {
          print("Error: $e");
        }
        return [];
      }
    } else {
      return activityItemList;
    }
  }

  static Future<ActivityStat?> getActivitiesStatByUserID(
    String userID,
  ) async {
    final response = await BaseService.makeAuthenticatedRequest(
      '${BaseService.BASE_URL}/custom-api/activity-summary?patientId=$userID',
      method: 'GET',
    );
    var responseMap = jsonDecode(response.body);
    if (response.statusCode == 200 && responseMap['success']) {
      try {
        ActivityStat activityStat =
            ActivityStat.fromJson(responseMap['summary']);
        return activityStat;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<int> getActivityCount(String userID, String date) async {
    final response = await BaseService.makeAuthenticatedRequest(
      '${BaseService.BASE_URL}/items/activity_log?filter={"_and":[{"user_created":"$userID"},{"date":{"_eq":"$date"}}]}&meta=*',
      method: 'GET',
    );
    var responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseMap["meta"]["filter_count"] ?? 0;
    } else {
      return 0;
    }
  }
}
