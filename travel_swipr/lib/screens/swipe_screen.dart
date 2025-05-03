import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../components/place_card.dart';
import '../models/travel_place.dart';
import '../theme/app_theme.dart';
import '../viewmodels/travel_viewmodel.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({Key? key}) : super(key: key);

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  late CardSwiperController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = CardSwiperController();
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TravelViewModel>(context);
    final places = viewModel.filteredPlaces;
    final String typeText = viewModel.selectedType == 'all' 
        ? 'All Places' 
        : viewModel.selectedType == 'hotel' 
            ? 'Hotels' 
            : 'Destinations';
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Explore $typeText',
              style: TextStyle(color: AppTheme.textColor, fontWeight: FontWeight.bold),
            ),
            Text(
              'Budget: \$${viewModel.budget.toInt()} • ${viewModel.days} days',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryTextColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            onSelected: (String type) {
              viewModel.setSelectedType(type);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'all',
                child: Text(
                  'All Places',
                  style: TextStyle(
                    fontWeight: viewModel.selectedType == 'all' 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                    color: viewModel.selectedType == 'all'
                        ? AppTheme.primaryColor
                        : AppTheme.textColor,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'hotel',
                child: Text(
                  'Hotels Only',
                  style: TextStyle(
                    fontWeight: viewModel.selectedType == 'hotel' 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                    color: viewModel.selectedType == 'hotel'
                        ? AppTheme.primaryColor
                        : AppTheme.textColor,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'destination',
                child: Text(
                  'Destinations Only',
                  style: TextStyle(
                    fontWeight: viewModel.selectedType == 'destination' 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                    color: viewModel.selectedType == 'destination'
                        ? AppTheme.primaryColor
                        : AppTheme.textColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: places.isEmpty
          ? _buildEmptyState()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: CardSwiper(
                      controller: _cardController,
                      cardsCount: places.length,
                      onSwipe: (int previousIndex, int? currentIndex, CardSwiperDirection direction) {
                        if (direction == CardSwiperDirection.right) {
                          viewModel.swipeRight(places[previousIndex]);
                        } else if (direction == CardSwiperDirection.left) {
                          viewModel.swipeLeft(places[previousIndex]);
                        }
                        
                        // Return true to confirm the swipe
                        return true;
                      },
                      numberOfCardsDisplayed: 3,
                      backCardOffset: const Offset(40, 40),
                      padding: const EdgeInsets.all(24.0),
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        final place = places[index];
                        final isLiked = viewModel.isPlaceLiked(place);
                        
                        return PlaceCard(
                          place: place,
                          isLiked: isLiked,
                          onLike: () {
                            _cardController.swipeRight();
                          },
                          onUnlike: () {
                            _cardController.swipeLeft();
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          icon: Icons.close,
                          backgroundColor: Colors.red.shade100,
                          iconColor: Colors.red,
                          onTap: () {
                            _cardController.swipeLeft();
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.favorite,
                          backgroundColor: Colors.green.shade100,
                          iconColor: Colors.green,
                          onTap: () {
                            _cardController.swipeRight();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: AppTheme.secondaryTextColor,
            ),
            SizedBox(height: 16),
            Text(
              'No destinations found',
              style: AppTheme.headingStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Try adjusting your budget or number of days to find more options',
              style: AppTheme.captionStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 32,
        ),
      ),
    );
  }
} 