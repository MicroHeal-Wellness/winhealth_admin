import 'dart:convert';

import 'package:winhealth_admin/models/appointment.dart';
import 'package:winhealth_admin/services/base_service.dart';

class AppointmentService {
  static Future<List<Appointment>> getAppointmentsByDocterIDandDate(
      String userID, String date) async {
    final response = await BaseService.makeUnauthenticatedRequest(
      '${BaseService.BASE_URL}/appointments/doctor?doctor_id=$userID&date=$date',
      method: 'GET',
    );
    final List<Appointment> data = [];
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson) {
        data.add(Appointment.fromJson(appointment));
      }
      return data;
    } else {
      return data;
    }
  }

  static Future<bool> updateNotes(payload, id) async {
    print("payload: ");
    print(payload);
    final response = await BaseService.makeUnauthenticatedRequest(
        '${BaseService.BASE_URL}/appointments/$id',
        method: 'PATCH',
        body: jsonEncode(payload));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
