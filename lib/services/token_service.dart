import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenService {
  static String baseUrl = "http://localhost:5000/api/a/auths";

  static Future<String> getToken() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return "";
    } else {
      throw Exception('Failed to load categories');
    }
  }
}