import 'dart:convert';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/base_service.dart';

class PatientService {
  static Future<List<UserModel>> getPatients() async {
    final response = await BaseService.makeUnauthenticatedRequest(
      '${BaseService.BASE_URL}/users?filter[role][_eq]=a4f8c484-438d-4c9e-ac17-2b1c7ecd57e1',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final List<UserModel> data = [];
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson['data']) {
        data.add(UserModel.fromJson(appointment));
      }
      return data;
    } else {
      return [];
    }
  }
}
