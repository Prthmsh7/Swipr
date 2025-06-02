import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const SwiprApp());
}

/// =========================
/// Main App Widget
/// =========================
class SwiprApp extends StatelessWidget {
  const SwiprApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          elevation: 8,
          backgroundColor: Colors.white,
          indicatorColor: Colors.blue.withOpacity(0.1),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      home: const SwiprHomePage(),
    );
  }
}

/// =========================
/// Data Model: Destination
/// =========================
class Destination {
  final String name;
  final String imageUrl;
  final String description;
  final int budget;
  final int days;

  Destination({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.budget,
    required this.days,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      name: json['name'],
      imageUrl: json['image'],
      description: json['description'],
      budget: json['budget'],
      days: json['days'],
    );
  }
}

/// =========================
/// Main Screen with State
/// =========================
class SwiprHomePage extends StatefulWidget {
  const SwiprHomePage({super.key});

  @override
  State<SwiprHomePage> createState() => _SwiprHomePageState();
}

class _SwiprHomePageState extends State<SwiprHomePage> {
  int _selectedIndex = 0;
  final CardSwiperController _swiperController = CardSwiperController();
  RangeValues _budgetRange = const RangeValues(0, 20000);
  RangeValues _daysRange = const RangeValues(0, 10);
  List<Destination> _destinations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDestinations();
  }

  Future<void> _loadDestinations() async {
    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _destinations = [
        Destination(
          name: 'Paris, France',
          imageUrl: 'https://picsum.photos/800/1200',
          description: 'The City of Light, known for its iconic Eiffel Tower, world-class museums, and romantic atmosphere.',
          budget: 15000,
          days: 5,
        ),
        Destination(
          name: 'Tokyo, Japan',
          imageUrl: 'https://picsum.photos/800/1200',
          description: 'A vibrant metropolis where traditional culture meets cutting-edge technology.',
          budget: 20000,
          days: 7,
        ),
        // Add more destinations as needed
      ];
      _isLoading = false;
    });
  }

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildFavoritesScreen();
      case 2:
        return const SettingsScreen();
      default:
        return _buildHomeScreen();
    }
  }

  Widget _buildHomeScreen() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CardSwiper(
                controller: _swiperController,
                cardsCount: _destinations.length,
                onSwipe: (previousIndex, currentIndex, direction) {
                  // Handle swipe
                  return true;
                },
                numberOfCardsDisplayed: 1,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: _buildFrontCard(_destinations[index]),
                      back: _buildBackCard(_destinations[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Swipe right on destinations you like',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Destinations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildBudgetSlider(),
          const SizedBox(height: 16),
          _buildDurationSlider(),
        ],
      ),
    );
  }

  Widget _buildBudgetSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Budget Range',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              '₹${_budgetRange.start.round()} - ₹${_budgetRange.end.round()}',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        RangeSlider(
          min: 0,
          max: 20000,
          divisions: 20,
          activeColor: Colors.blue,
          inactiveColor: Colors.blue.withOpacity(0.2),
          labels: RangeLabels(
            '₹${_budgetRange.start.round()}',
            '₹${_budgetRange.end.round()}',
          ),
          values: _budgetRange,
          onChanged: (values) {
            setState(() {
              _budgetRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDurationSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Trip Duration',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              '${_daysRange.start.round()} - ${_daysRange.end.round()} days',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        RangeSlider(
          min: 0,
          max: 10,
          divisions: 10,
          activeColor: Colors.blue,
          inactiveColor: Colors.blue.withOpacity(0.2),
          labels: RangeLabels(
            '${_daysRange.start.round()} days',
            '${_daysRange.end.round()} days',
          ),
          values: _daysRange,
          onChanged: (values) {
            setState(() {
              _daysRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildFrontCard(Destination dest) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            dest.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 80),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dest.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(offset: Offset(0, 1), blurRadius: 3, color: Colors.black54),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.white.withOpacity(0.9)),
                  const SizedBox(width: 4),
                  Text(
                    '${dest.days} days',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.attach_money, size: 16, color: Colors.white.withOpacity(0.9)),
                  const SizedBox(width: 4),
                  Text(
                    '₹${dest.budget}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackCard(Destination dest) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dest.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              dest.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.calendar_today,
                  label: '${dest.days} days',
                ),
                const SizedBox(width: 12),
                _buildInfoChip(
                  icon: Icons.attach_money,
                  label: '₹${dest.budget}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blue[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
