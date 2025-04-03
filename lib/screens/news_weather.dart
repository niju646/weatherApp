import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/news_service.dart';
import '../models/news.dart';

class WeatherNewsScreen extends StatefulWidget {
  @override
  _WeatherNewsScreenState createState() => _WeatherNewsScreenState();
}

class _WeatherNewsScreenState extends State<WeatherNewsScreen> {
  final NewsService _newsService = NewsService();
  late Future<List<News>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsService.getLatestWeatherNews();
  }

  // Function to determine background image based on news description
  String _getBackgroundImage(String? description) {
    if (description == null) return 'assets/cloudy.jpg'; // Default image
    final desc = description.toLowerCase();
    if (desc.contains('clear') || desc.contains('sun') || desc.contains('sunny')) {
      return 'assets/sun.jpg';
    } else if (desc.contains('rain') || desc.contains('shower') || desc.contains('storm')) {
      return 'assets/rainy.jpg';
    } else if (desc.contains('cloud') || desc.contains('overcast')) {
      return 'assets/cloudy.jpg';
    } else if (desc.contains('snow') || desc.contains('blizzard')) {
      return 'assets/snowy.jpg';
    }
    return 'assets/cloudy.jpg'; // Fallback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latest Weather News')),
      body: FutureBuilder<List<News>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          // Determine the background based on the first news article (if available)
          String backgroundImage = 'assets/cloudy.jpg'; // Default
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            backgroundImage = _getBackgroundImage(snapshot.data![0].description);
          }

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : snapshot.hasError
                    ? Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)))
                    : snapshot.data!.isEmpty
                        ? Center(child: Text('No news available', style: TextStyle(color: Colors.white)))
                        : RefreshIndicator(
                            onRefresh: () async {
                              setState(() {
                                _newsFuture = _newsService.getLatestWeatherNews();
                              });
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.all(16.0),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final news = snapshot.data![index];
                                return NewsCard(news: news);
                              },
                            ),
                          ),
          );
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white.withOpacity(0.9),
      child: ExpansionTile(
        title: Text(news.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(news.publishedAt.substring(0, 10)), // Show date only
        leading: news.imageUrl != null
            ? Image.network(news.imageUrl!, width: 50, fit: BoxFit.cover)
            : Icon(Icons.article),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(news.description),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(news.url);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not launch ${news.url}')),
                      );
                    }
                  },
                  child: Text('Read Full Article'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}