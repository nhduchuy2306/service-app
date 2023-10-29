import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:service_app/models/category.dart';
import 'package:service_app/utils/constant.dart';

class CategoryService {
  static Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    final response =
        await http.get(Uri.parse("${Constant.baseUrlProduct}/p/categories"));
    if (response.statusCode == 200) {
      var categoriesJson = json.decode(utf8.decode(response.bodyBytes));
      for (var categoryJson in categoriesJson) {
        categories.add(Category.fromJson(categoryJson));
      }
    } else {
      throw Exception('Failed to load categories');
    }

    return categories;
  }

  static Future<List<Category>> top3Categories() async {
    List<Category> categories = [];
    int count = 0;

    final response =
        await http.get(Uri.parse("${Constant.baseUrlProduct}/p/categories"));
    if (response.statusCode == 200) {
      var categoriesJson = json.decode(utf8.decode(response.bodyBytes));
      for (var categoryJson in categoriesJson) {
        if (count < 3) {
          categories.add(Category.fromJson(categoryJson));
          count++;
        }
      }
    } else {
      throw Exception('Failed to load categories');
    }

    return categories;
  }
}
