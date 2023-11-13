import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/services/news_services.dart';
import 'package:news_app/widgets/news_list.dart';

class CategoryNews extends StatelessWidget {
  final Category category;
  final NewsService;

  CategoryNews(
      {required this.category, this.NewsService, required newsService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Article>>(
        future: NewsService.getNewsForCategory(category.name.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return NewsList(snapshot.data!);
          } else {
            return const Center(
              child: Text('No news available for this category.'),
            );
          }
        },
      ),
    );
  }
}
