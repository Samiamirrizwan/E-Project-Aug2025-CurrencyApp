// lib/features/news/data/news_repository.dart

import 'dart:convert';
import 'package:currensee/features/news/data/models/news_article.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  // !! IMPORTANT !!
  // Replace this with your own API key from newsapi.org
  final String _apiKey = '839ee3c74c8842b88159d23fa2a4d0c2';
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<NewsArticle>> fetchFinancialNews() async {
    // Fetching business news from the US as it's often relevant to currency
    final url = '$_baseUrl?country=us&category=business&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articlesJson = data['articles'];
        // Filter out articles that have been removed or have no title
        return articlesJson
            .where(
                (json) => json['title'] != null && json['title'] != '[Removed]')
            .map((json) => NewsArticle.fromJson(json))
            .toList();
      } else {
        // Handle non-200 responses
        final error = json.decode(response.body);
        throw Exception('Failed to load news: ${error['message']}');
      }
    } catch (e) {
      // Handle network errors or other exceptions
      throw Exception('Failed to load news. Check your connection or API key.');
    }
  }
}
