import 'dart:convert';

import 'package:winhealth_admin/models/patient.dart';
import 'package:winhealth_admin/services/base_service.dart';

class PatientService {
  static Future<List<Patient>> getPatients() async {
    final response = await BaseService.makeUnauthenticatedRequest(
      '${BaseService.BASE_URL}/patient',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final List<Patient> data = [];
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson) {
        data.add(Patient.fromJson(appointment));
      }
      return data;
    } else {
      return [];
    }
  }
}
