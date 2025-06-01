import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flip_card/flip_card.dart';

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
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
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

  /// -------------------------
  /// Load destinations from JSON string (simulate destinations.json)
  /// -------------------------
  final String _destinationsJson = '''
  [
    {
      "name": "Manali",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "A serene hill station in Himachal Pradesh.",
      "budget": 8000,
      "days": 4
    },
    {
      "name": "Goa",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "Beach paradise with nightlife and water sports.",
      "budget": 12000,
      "days": 5
    },
    {
      "name": "Jaipur",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "The Pink City known for forts, palaces, and culture.",
      "budget": 7000,
      "days": 3
    },
    {
      "name": "Rishikesh",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "Yoga capital with river rafting and the Ganges.",
      "budget": 6500,
      "days": 3
    },
    {
      "name": "Ladakh",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "Mountains, monasteries, and adventure at high altitude.",
      "budget": 18000,
      "days": 6
    },
    {
      "name": "Darjeeling",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "Tea gardens and toy trains in the Himalayas.",
      "budget": 9500,
      "days": 4
    },
    {
      "name": "Pondicherry",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "French colonial charm on the east coast.",
      "budget": 8500,
      "days": 4
    },
    {
      "name": "Udaipur",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "Lakes, palaces, and romantic vibes in Rajasthan.",
      "budget": 9000,
      "days": 3
    },
    {
      "name": "Munnar",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "Lush green tea hills in Kerala's highlands.",
      "budget": 10000,
      "days": 4
    },
    {
      "name": "Andaman Islands",
      "image": "https://images.unsplash.com/photo-1554797589-7241bb691973",
      "description": "Clear waters, scuba diving, and remote beaches.",
      "budget": 20000,
      "days": 6
    }
  ]
  ''';

  late final List<Destination> destinations;

  /// -------------------------
  /// Sliders for filtering
  /// -------------------------
  RangeValues _budgetRange = const RangeValues(0, 20000);
  RangeValues _daysRange = const RangeValues(0, 10);

  @override
  void initState() {
    super.initState();
    final List<dynamic> jsonList = json.decode(_destinationsJson);
    destinations = jsonList.map((e) => Destination.fromJson(e)).toList();
  }

  /// -------------------------
  /// Filtered list based on budget and days sliders
  /// -------------------------
  List<Destination> get filteredDestinations {
    return destinations.where((d) {
      return d.budget >= _budgetRange.start &&
          d.budget <= _budgetRange.end &&
          d.days >= _daysRange.start &&
          d.days <= _daysRange.end;
    }).toList();
  }

  /// -------------------------
  /// UI: Build glassmorphic title overlay for card
  /// -------------------------
  Widget _buildGlassmorphicTitle(String title) {
    return Positioned(
      bottom: 10,
      left: 10,
      right: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(offset: Offset(0, 0), blurRadius: 5, color: Colors.black54),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  /// -------------------------
  /// UI: Front side of the flip card
  /// -------------------------
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
        _buildGlassmorphicTitle(dest.name),
      ],
    );
  }

  /// -------------------------
  /// UI: Back side of the flip card
  /// -------------------------
  Widget _buildBackCard(Destination dest) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dest.name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              dest.description,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Text(
              'Budget: ₹${dest.budget}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'Duration: ${dest.days} days',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  /// -------------------------
  /// UI: Budget Range Slider
  /// -------------------------
  Widget buildBudgetSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Budget Range (₹)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        RangeSlider(
          min: 0,
          max: 20000,
          divisions: 20,
          labels: RangeLabels(
            _budgetRange.start.round().toString(),
            _budgetRange.end.round().toString(),
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

  /// -------------------------
  /// UI: Days Range Slider
  /// -------------------------
  Widget buildDurationSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trip Duration (days)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        RangeSlider(
          min: 0,
          max: 10,
          divisions: 10,
          labels: RangeLabels(
            _daysRange.start.round().toString(),
            _daysRange.end.round().toString(),
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

  /// -------------------------
  /// Bottom Navigation Bar Builder
  /// -------------------------
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          // TODO: handle navigation if needed
        });
      },
    );
  }

  /// -------------------------
  /// Main build method
  /// -------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipr Travel Destinations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            buildBudgetSlider(),
            const SizedBox(height: 8),
            buildDurationSlider(),
            const SizedBox(height: 12),
            Expanded(
              child: CardSwiper(
                cardsCount: filteredDestinations.length,
                cardBuilder: (context, index, _, __) {
                  final dest = filteredDestinations[index];
                  return SizedBox(
                    width: 320,
                    height: 400,
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: _buildFrontCard(dest),
                      back: _buildBackCard(dest),
                    ),
                  );
                },
                padding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
