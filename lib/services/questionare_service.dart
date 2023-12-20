import 'dart:convert';

import 'package:winhealth_admin/models/answer.dart';
import 'package:winhealth_admin/models/question.dart';
import 'package:winhealth_admin/services/base_service.dart';

class QuestionareService {
  static Future<List<Question>> getAllQuestion() async {
    final response = await BaseService.makeUnauthenticatedRequest(
      '${BaseService.BASE_URL}/quesionnaire',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final List<Question> data = [];
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson) {
        data.add(Question.fromJson(appointment));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<Answer>> getAllAnswerByUserId(String userId) async {
    final response = await BaseService.makeUnauthenticatedRequest(
      '${BaseService.BASE_URL}/quesionnaire/getResponse?patient_id=$userId',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final List<Answer> data = [];
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson) {
        data.add(Answer.fromJson(appointment));
      }
      return data;
    } else {
      return [];
    }
  }
}
