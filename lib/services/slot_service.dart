import 'dart:convert';

import 'package:winhealth_admin/models/slot.dart';
import 'package:winhealth_admin/services/base_service.dart';

class SlotService {
  static Future<List<Slot>> getSlotsByDocterID(
      String userID, String date) async {
    final response = await BaseService.makeUnauthenticatedRequest(
      '${BaseService.BASE_URL}/slots?doctor_id=$userID&from_date=$date',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final List<Slot> data = [];
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson) {
        data.add(Slot.fromJson(appointment));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<bool> createSlotsByDocterID(
      String userID, String date, String time, String status) async {
    final response = await BaseService.makeUnauthenticatedRequest(
        '${BaseService.BASE_URL}/slots',
        method: 'POST',
        body: jsonEncode({
          "doctor_id": int.parse(userID),
          "start_time": time,
          "duration": 30,
          "status": status,
          "date": date
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
