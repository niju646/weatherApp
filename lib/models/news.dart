class News {
  final String title;
  final String description;
  final String url;
  final String publishedAt;
  final String? imageUrl;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.publishedAt,
    this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      imageUrl: json['urlToImage'],
    );
  }
}