import 'dart:convert';

import 'package:winhealth_admin/models/activity_stat.dart';
import 'package:winhealth_admin/services/base_service.dart';

class ActivityService {
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
}