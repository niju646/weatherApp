import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';

class HistoryService {
  static const String _historyKey = 'weather_history';

  Future<List<Weather>> getWeatherHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString(_historyKey);
    if (historyString == null) return [];
    final List<dynamic> historyJson = jsonDecode(historyString);
    return historyJson.map((json) => Weather.fromJsonHistory(json)).toList();
  }

  Future<void> addWeatherToHistory(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getWeatherHistory();
    history.insert(0, weather); // Add to the top
    if (history.length > 10) history.removeLast(); // Limit to 10 entries
    await prefs.setString(_historyKey, jsonEncode(history.map((w) => w.toJson()).toList()));
  }
}