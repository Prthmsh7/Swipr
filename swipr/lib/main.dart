import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'models/destination.dart';

void main() {
  runApp(const SwiprApp());
}

class SwiprApp extends StatelessWidget {
  const SwiprApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipr',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      home: const SwiprHomePage(),
    );
  }
}

class SwiprHomePage extends StatefulWidget {
  const SwiprHomePage({super.key});

  @override
  State<SwiprHomePage> createState() => _SwiprHomePageState();
}

class _SwiprHomePageState extends State<SwiprHomePage> {
  List<Destination> destinations = [];
  List<Destination> filteredDestinations = [];

  double maxBudget = 20000;
  double selectedBudget = 20000;

  int maxDays = 15;
  int selectedDays = 15;

  int _selectedIndex = 0;

  final CardSwiperController _controller = CardSwiperController();

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    final String response = await rootBundle.loadString('assets/destinations.json');
    final data = await json.decode(response) as List;
    setState(() {
      destinations = data.map((json) => Destination.fromJson(json)).toList();
      filteredDestinations = List.from(destinations);
    });
  }

  void _filterDestinations() {
    setState(() {
      filteredDestinations = destinations.where((destination) {
        return destination.budget <= selectedBudget && destination.days <= selectedDays;
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHome() {
    return Column(
      children: [
        // Filters Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // Budget Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Budget:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('₹${selectedBudget.toInt()}'),
                ],
              ),
              Slider(
                value: selectedBudget,
                min: 1000,
                max: maxBudget,
                divisions: (maxBudget ~/ 1000),
                label: '₹${selectedBudget.toInt()}',
                onChanged: (value) {
                  setState(() {
                    selectedBudget = value;
                    _filterDestinations();
                  });
                },
              ),
              // Days Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Days:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('$selectedDays'),
                ],
              ),
              Slider(
                value: selectedDays.toDouble(),
                min: 1,
                max: maxDays.toDouble(),
                divisions: maxDays,
                label: '$selectedDays',
                onChanged: (value) {
                  setState(() {
                    selectedDays = value.toInt();
                    _filterDestinations();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredDestinations.isEmpty
              ? const Center(child: Text('No destinations match your filters.'))
              : CardSwiper(
                  cardsCount: filteredDestinations.length,
                  cardBuilder: (context, index, realIndex, direction) {
                    final destination = filteredDestinations[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          destination.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  controller: _controller,
                  onSwipe: (index, directionIndex, direction) {
                    debugPrint('Swiped card $index in direction $direction');
                    return true;
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFavorites() {
    return const Center(child: Text('Favorites Page - Coming Soon'));
  }

  Widget _buildSettings() {
    return const Center(child: Text('Settings Page - Coming Soon'));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildHome(),
      _buildFavorites(),
      _buildSettings(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipr'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
