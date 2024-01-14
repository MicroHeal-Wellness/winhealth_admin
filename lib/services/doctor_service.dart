import 'dart:convert';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/base_service.dart';

class DoctorService {
  static Future<List<UserModel>> getDoctors() async {
    final response = await BaseService.makeUnauthenticatedRequest(
      '${BaseService.BASE_URL}/users?filter[role][_eq]=881dbecd-f779-4c65-927d-b07d39b336cb&limit=-1',
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

  static Future<bool> udpateDoctor(String id, payload) async {
    final response = await BaseService.makeAuthenticatedRequest(
      '${BaseService.BASE_URL}/users/$id',
      method: 'PATCH',
      body: jsonEncode(payload),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
