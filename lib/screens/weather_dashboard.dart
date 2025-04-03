import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/providers/auth_provider.dart';
import 'package:weatherapp/screens/weather_news_screen.dart';
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
  


  
  

  // Function to determine background image based on weather description
  String _getBackgroundImage(String? description) {
    if (description == null) return 'assets/cloudy.jpg'; // Default image
    final desc = description.toLowerCase();
    if (desc.contains('clear') || desc.contains('sun')) return 'assets/sun.jpg';
    if (desc.contains('rain') || desc.contains('shower')) return 'assets/rainy.jpg';
    if (desc.contains('cloud')) return 'assets/cloudy.jpg'; // Fixed typo
    if (desc.contains('snow')) return 'assets/snowy.jpg'; // Fixed typo
    return 'assets/cloudy.jpg'; // Fallback
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.user?.accessToken ?? '';

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Dashboard"),
      // ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_getBackgroundImage(_weather?.description)),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 50,),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration( 
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final weather = await _weatherService.getWeather(_cityController.text, token);
                      setState(()  {
                        _weather = weather;
                        
                      });
                    } catch (e) {
                      try {
                        await authProvider.refresh();
                        final weather = await _weatherService.getWeather(
                          _cityController.text,
                          authProvider.user!.accessToken,
                        );
                        
                        setState(()  {
                          _weather = weather;
                          
                        });
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      }
                    }
                  },
                  child: const Text("Get Weather"),
                ),
                if (_weather != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    'City: ${_weather!.city}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Temperature: ${_weather!.temperature}°C',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Description: ${_weather!.description}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
                // Add this to the Column in WeatherDashboard
// ElevatedButton(
//   onPressed: () {
//    // Navigator.push(context, MaterialPageRoute(builder: (_) => WeatherNewsScreen()));
//   },
//   child: Text('View Latest Weather News'),
// ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
