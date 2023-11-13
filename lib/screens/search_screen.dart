import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedCountry = 'in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search News by Country'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Select Country',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Center(
              child: DropdownButton<String>(
                value: selectedCountry,
                items: const [
                  DropdownMenuItem(
                    value: 'us',
                    child: Text('United States'),
                  ),
                  DropdownMenuItem(
                    value: 'gb',
                    child: Text('United Kingdom'),
                  ),
                  DropdownMenuItem(
                    value: 'ca',
                    child: Text('Canada'),
                  ),
                  DropdownMenuItem(
                    value: 'au',
                    child: Text('Australia'),
                  ),
                  DropdownMenuItem(
                    value: 'in',
                    child: Text('India'),
                  ),
                  DropdownMenuItem(
                    value: 'de',
                    child: Text('Germany'),
                  ),
                  DropdownMenuItem(
                    value: 'fr',
                    child: Text('France'),
                  ),
                  DropdownMenuItem(
                    value: 'jp',
                    child: Text('Japan'),
                  ),
                  DropdownMenuItem(
                    value: 'br',
                    child: Text('Brazil'),
                  ),
                  DropdownMenuItem(
                    value: 'ru',
                    child: Text('Russia'),
                  ),
                  DropdownMenuItem(
                    value: 'cn',
                    child: Text('China'),
                  ),
                  DropdownMenuItem(
                    value: 'kr',
                    child: Text('South Korea'),
                  ),
                  DropdownMenuItem(
                    value: 'za',
                    child: Text('South Africa'),
                  ),
                  DropdownMenuItem(
                    value: 'eg',
                    child: Text('Egypt'),
                  ),
                  DropdownMenuItem(
                    value: 'ng',
                    child: Text('Nigeria'),
                  ),
                  DropdownMenuItem(
                    value: 'mx',
                    child: Text('Mexico'),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text('Argentina'),
                  ),
                  DropdownMenuItem(
                    value: 'it',
                    child: Text('Italy'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value!;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, selectedCountry);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            ),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
