class Weather {
  final String city;
  final double temperature;
  final String description;
  final DateTime timestamp;

  Weather({required this.city, required this.temperature, required this.description,required this.timestamp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      timestamp: DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() => {
        'city': city,
        'temperature': temperature,
        'description': description,
        'timestamp': timestamp.toIso8601String(),
      };
      factory Weather.fromJsonHistory(Map<String, dynamic> json) {
    return Weather(
      city: json['city'],
      temperature: json['temperature'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}