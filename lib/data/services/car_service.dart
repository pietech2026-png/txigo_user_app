import 'dart:convert';
import '../models/car_category.dart';
import 'api_service.dart';

class CarService {
  static Future<List<CarCategory>> getCarCategories() async {
    try {
      final response = await ApiService.get('/car-categories');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => CarCategory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load car categories');
      }
    } catch (e) {
      print('Error fetching car categories: $e');
      return [];
    }
  }
}
