import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/services/news_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatelessWidget {
  final List<Article> articles;

  const NewsList(this.articles, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return GestureDetector(
          onTap: () {
            _navigateToFullArticle(context, article);
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            color: const Color.fromARGB(221, 39, 36, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: article.urlToImage,
                  fit: BoxFit.cover,
                  height: 200.0,
                  placeholder: (context, url) => LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Container(
                  color: Colors.black.withOpacity(0.6),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article.description,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Published on ${article.publishedAt}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () => _shareArticle(article),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToFullArticle(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullArticleScreen(article: article),
      ),
    );
  }

  void _shareArticle(Article article) {
    Share.share(
      '${article.title}\n${article.url}',
      subject: article.title,
    );
  }
}

class FullArticleScreen extends StatelessWidget {
  final Article article;

  const FullArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage,
              fit: BoxFit.cover,
              height: 200.0,
              placeholder: (context, url) => LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Published on ${article.publishedAt}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _launchURL(article.url),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                    ),
                    child: const Text('Read Article'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.description,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      print('Could not launch $url: $e');
    }
  }
}
