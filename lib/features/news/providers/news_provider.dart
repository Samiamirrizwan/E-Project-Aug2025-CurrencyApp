// lib/features/news/providers/news_provider.dart

import 'package:currensee/features/news/data/models/news_article.dart';
import 'package:currensee/features/news/data/news_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository();
});

final newsFeedProvider = FutureProvider<List<NewsArticle>>((ref) async {
  return ref.watch(newsRepositoryProvider).fetchFinancialNews();
});
