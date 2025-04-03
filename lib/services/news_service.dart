import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsService {
  final String baseUrl = 'http://localhost:5000/api/weather';

  Future<List<News>> getLatestWeatherNews() async {
    final response = await http.get(Uri.parse('$baseUrl/news/latest'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => News.fromJson(json)).toList();
    }
    throw Exception('Failed to fetch news');
  }
}