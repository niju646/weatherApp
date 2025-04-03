// import 'package:flutter/material.dart';
// import '../services/news_service.dart';
// import '../models/news.dart';

// class WeatherNewsScreen extends StatefulWidget {
//   @override
//   _WeatherNewsScreenState createState() => _WeatherNewsScreenState();
// }

// class _WeatherNewsScreenState extends State<WeatherNewsScreen> {
//   final NewsService _newsService = NewsService();
//   late Future<List<News>> _newsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _newsFuture = _newsService.getLatestWeatherNews();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Latest Weather News')),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/cloudy.jpg'), // Default background
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
//           ),
//         ),
//         child: FutureBuilder<List<News>>(
//           future: _newsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('No news available', style: TextStyle(color: Colors.white)));
//             }

//             final newsList = snapshot.data!;
//             return ListView.builder(
//               padding: EdgeInsets.all(16.0),
//               itemCount: newsList.length,
//               itemBuilder: (context, index) {
//                 final news = newsList[index];
//                 return NewsCard(news: news);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class NewsCard extends StatelessWidget {
//   final News news;

//   NewsCard({required this.news});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       color: Colors.white.withOpacity(0.9),
//       child: ExpansionTile(
//         title: Text(news.title, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(news.publishedAt.substring(0, 10)), // Show date only
//         leading: news.imageUrl != null
//             ? Image.network(news.imageUrl!, width: 50, fit: BoxFit.cover)
//             : Icon(Icons.article),
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(news.description),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Optionally, open the full article in a browser
//                     // Requires url_launcher package
//                   },
//                   child: Text('Read Full Article'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }