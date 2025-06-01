import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
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
  double _budget = 20000;
  double _days = 7;

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    final String response =
        await rootBundle.loadString('assets/destinations.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      destinations = data.map((json) => Destination.fromJson(json)).toList();
      filterDestinations();
    });
  }

  void filterDestinations() {
    setState(() {
      filteredDestinations = destinations
          .where((d) => d.budget <= _budget && d.days <= _days)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swipr", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          // Budget Slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Max Budget: ₹${_budget.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Slider(
                  value: _budget,
                  min: 5000,
                  max: 50000,
                  divisions: 45,
                  label: _budget.toInt().toString(),
                  onChanged: (value) {
                    setState(() {
                      _budget = value;
                      filterDestinations();
                    });
                  },
                ),
                const SizedBox(height: 12),
                Text('Max Days: ${_days.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Slider(
                  value: _days,
                  min: 1,
                  max: 15,
                  divisions: 14,
                  label: _days.toInt().toString(),
                  onChanged: (value) {
                    setState(() {
                      _days = value;
                      filterDestinations();
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filteredDestinations.isEmpty
                ? const Center(child: Text("No destinations match your criteria."))
                : CardSwiper(
                    cardsCount: filteredDestinations.length,
                    cardBuilder: (context, index, realIndex, cardsCount) {
                      final destination = filteredDestinations[index];
                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.network(
                                  destination.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) => const Center(
                                      child: Icon(Icons.broken_image, size: 48)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(destination.name,
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Text(destination.description),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("₹${destination.budget}"),
                                      Text("${destination.days} days"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    controller: CardSwiperController(),
                    onSwipe: (index, _, direction) {
                      debugPrint('Swiped card $index in direction $direction');
                      return true;
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
