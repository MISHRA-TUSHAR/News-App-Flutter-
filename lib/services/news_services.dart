import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '85940a4d7b23488ba7ecd9e9e7c6533e';

class NewsService {
  Future<List<Article>> getTopHeadlines(String country) async {
    if (country.isEmpty) {
      return [];
    }

    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey',
      ),
    );

    print('Top Headlines API Response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Article> articles = (jsonData['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList();
      return articles;
    } else {
      // error
      throw Exception('Failed to load top headlines');
    }
  }

  Future<List<Article>> searchArticles(String query) async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey'),
    );

    print('Search Articles API Response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Article> articles = (jsonData['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to search articles');
    }
  }

  Future<List<Article>> getTopHeadlinesByCategory(String category) async {
    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=$category&apiKey=$apiKey',
      ),
    );

    print('Top Headlines By Category API Response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Article> articles = (jsonData['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load top headlines by category');
    }
  }

  Future<String> fetchFullArticleContent(String articleUrl) async {
    final response = await http.get(
      Uri.parse(articleUrl),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch full article content');
    }
  }
}

Future<List<Article>> getNewsForCategory(String category) async {
  if (category.isEmpty) {
    return [];
  }

  final response = await http.get(
    Uri.parse(
      'https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=$apiKey',
    ),
  );

  print('Category News API Response: ${response.body}');

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    List<Article> articles = (jsonData['articles'] as List)
        .map((article) => Article.fromJson(article))
        .toList();
    return articles;
  } else {
    throw Exception('Failed to load category news');
  }
}

class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String content;
  final DateTime publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.content,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      content: json['content'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt'] ?? ''),
    );
  }
}
