import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../components/place_card.dart';
import '../theme/app_theme.dart';
import '../viewmodels/travel_viewmodel.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TravelViewModel>(context);
    final likedPlaces = viewModel.likedPlaces;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Destinations',
          style: TextStyle(color: AppTheme.textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: likedPlaces.isEmpty
          ? _buildEmptyState()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: likedPlaces.length,
                  itemBuilder: (context, index) {
                    final place = likedPlaces[index];
                    
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: PlaceCard(
                              place: place,
                              isLiked: true,
                              onUnlike: () {
                                viewModel.unlikePlace(place);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
              Icons.favorite_border,
              size: 80,
              color: AppTheme.secondaryTextColor,
            ),
            SizedBox(height: 16),
            Text(
              'No saved destinations yet',
              style: AppTheme.headingStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Swipe right on destinations you like to save them here',
              style: AppTheme.captionStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 