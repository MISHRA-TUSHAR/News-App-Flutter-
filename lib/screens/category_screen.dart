import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Business', icon: Icons.business),
    Category(name: 'Entertainment', icon: Icons.movie),
    Category(name: 'General', icon: Icons.public),
    Category(name: 'Health', icon: Icons.local_hospital),
    Category(name: 'Science', icon: Icons.science),
    Category(name: 'Sports', icon: Icons.sports),
    Category(name: 'Technology', icon: Icons.computer),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return CategoryCard(category: categories[index]);
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onCategorySelected(context, category);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 48.0, color: Colors.orange),
            const SizedBox(height: 12.0),
            Text(
              category.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }

  void _onCategorySelected(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryNews(
          category: category,
          newsService: null,
        ),
      ),
    );
  }
}
