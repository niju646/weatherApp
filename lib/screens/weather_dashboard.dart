import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/providers/auth_provider.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherDashboard extends StatefulWidget {
  const WeatherDashboard({super.key});

  @override
  State<WeatherDashboard> createState() => _WeatherDashboardState();
}

class _WeatherDashboardState extends State<WeatherDashboard> {

final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.user!.accessToken;
    
    return  Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(padding: EdgeInsets.all(16.0,)
      ,child: Column(
        children: [
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: "city",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )
            ),
          ),
          const SizedBox(height: 20,),
         ElevatedButton(onPressed: 
         () async {
              try{
                final weather = await _weatherService.getWeather(_cityController.text, token);
                  setState(() => _weather = weather);
              }catch(e){
                  try {
                    await authProvider.refresh();
                    final weather = await _weatherService.getWeather(_cityController.text, authProvider.user!.accessToken);
                    setState(() => _weather = weather);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
              }
         }, child: Text("Get Weather"),),
         if(_weather != null) ...[
          SizedBox(height: 20,),
          Text('city:${_weather!.city}',style: TextStyle(
            fontSize: 20,
          ),),
          Text('Temperature: ${_weather!.temperature}°C', style: TextStyle(fontSize: 20)),
          Text('Description: ${_weather!.description}', style: TextStyle(fontSize: 20)),
         ]
        ],
      ),
      ),
    );
  }
}