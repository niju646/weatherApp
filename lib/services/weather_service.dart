import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  final String baseUrl = 'http://localhost/api/weather';

  Future<Weather> getWeather(String city, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$city'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to fetch weather');
  }
}