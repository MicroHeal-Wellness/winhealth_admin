import 'dart:convert';

import 'package:winhealth_admin/models/food_item.dart';
import 'package:winhealth_admin/models/recommended_diet.dart';
import 'package:winhealth_admin/services/base_service.dart';

class DietService {
  static dynamic typeRankList = {
    'morning': 0,
    'afternoon': 1,
    'evening': 2,
    'night': 3,
  };
  static Future<List<RecommendedDiet>> getRecommendedDietByPatientID(
      String patinetId) async {
    final response = await BaseService.makeAuthenticatedRequest(
      '${BaseService.BASE_URL}/items/recommended_diet?fields=*,items.recommended_diet_item_id.*,items.recommended_diet_item_id.food_item.*,user_created.*,user_updated.*&filter[patient][_eq]=$patinetId',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final List<RecommendedDiet> data = [];
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson['data']) {
        data.add(RecommendedDiet.fromJson(appointment));
      }
      data.sort(
          (a, b) => typeRankList[a.type!].compareTo(typeRankList[b.type!]));
      return data;
    } else {
      return [];
    }
  }

  static Future<List<FoodItem>> getFoodItemsByQuery(String query) async {
    final response = await BaseService.makeAuthenticatedRequest(
      '${BaseService.BASE_URL}/items/food_items?search=$query',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final List<FoodItem> data = [];
      var responseJson = json.decode(response.body);
      for (final appointment in responseJson['data']) {
        data.add(FoodItem.fromJson(appointment));
      }
      return data;
    } else {
      return [];
    }
  }
}
