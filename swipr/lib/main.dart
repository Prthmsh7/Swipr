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
    return const MaterialApp(
      home: SwiprHomePage(),
      debugShowCheckedModeBanner: false,
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

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    final String response = await rootBundle.loadString('assets/destinations.json');
    final data = json.decode(response) as List;
    destinations = data.map((json) => Destination.fromJson(json)).toList();
    filteredDestinations = List.from(destinations);
    setState(() {});
  }

  void filterDestinations() {
    filteredDestinations = destinations.where((destination) {
      return destination.budget <= selectedBudget && destination.days <= selectedDays;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipr - Travel Picker'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: destinations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Column(
                    children: [
                      Text('Max Budget: ₹${selectedBudget.toInt()}'),
                      Slider(
                        min: 0,
                        max: maxBudget,
                        divisions: 20,
                        value: selectedBudget,
                        label: '₹${selectedBudget.toInt()}',
                        onChanged: (value) {
                          setState(() {
                            selectedBudget = value;
                            filterDestinations();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Text('Max Days: $selectedDays'),
                      Slider(
                        min: 1,
                        max: maxDays.toDouble(),
                        divisions: maxDays - 1,
                        value: selectedDays.toDouble(),
                        label: '$selectedDays days',
                        onChanged: (value) {
                          setState(() {
                            selectedDays = value.toInt();
                            filterDestinations();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredDestinations.isEmpty
                      ? const Center(child: Text('No destinations match the filters.'))
                      : CardSwiper(
                          cardsCount: filteredDestinations.length,
                          cardBuilder: (context, index, realIndex, cardsCount)  {
                            final destination = filteredDestinations[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 6,
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
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Center(child: Icon(Icons.image_not_supported)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(destination.name,
                                            style: const TextStyle(
                                                fontSize: 22, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text(destination.description),
                                        const SizedBox(height: 6),
                                        Text('Budget: ₹${destination.budget}'),
                                        Text('Days: ${destination.days}'),
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
