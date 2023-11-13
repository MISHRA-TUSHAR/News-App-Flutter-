import 'package:flutter/material.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/services/news_services.dart';
import 'package:news_app/widgets/bottom_navbar.dart';
import 'package:news_app/widgets/news_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService newsService = NewsService();
  late Future<List<Article>> articles;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    articles = newsService.getTopHeadlines('in');
  }

  void _openCategoryScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()),
    );
  }

  void _openSearchScreen(BuildContext context) async {
    final selectedCountry = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );

    if (selectedCountry != null && selectedCountry.isNotEmpty) {
      setState(() {
        articles = newsService.getTopHeadlines(selectedCountry);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Headlines',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Article>>(
        future: articles,
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
              child: Text('No news available.'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (index == 1) {
            _openCategoryScreen(context);
          } else if (index == 2) {
            _openSearchScreen(context);
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
