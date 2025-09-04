// lib/features/news/data/models/news_article.dart

class NewsArticle {
  final String title;
  final String source;
  final String url;
  final String? imageUrl;
  final DateTime publishedAt;

  NewsArticle({
    required this.title,
    required this.source,
    required this.url,
    this.imageUrl,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] as String,
      source: json['source']['name'] as String,
      url: json['url'] as String,
      imageUrl: json['urlToImage'] as String?,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );
  }
}
