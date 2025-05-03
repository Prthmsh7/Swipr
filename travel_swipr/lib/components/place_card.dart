import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import '../models/travel_place.dart';
import '../theme/app_theme.dart';

class PlaceCard extends StatelessWidget {
  final TravelPlace place;
  final bool isLiked;
  final VoidCallback? onLike;
  final VoidCallback? onUnlike;

  const PlaceCard({
    Key? key,
    required this.place,
    this.isLiked = false,
    this.onLike,
    this.onUnlike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with swiper
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      imageUrl: place.images[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade300,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    );
                  },
                  itemCount: place.images.length,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: AppTheme.primaryColor,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  control: SwiperControl(
                    color: Colors.white,
                    disableColor: Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        place.rating.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: place.type == 'hotel' 
                        ? AppTheme.primaryColor
                        : Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    place.type.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: AppTheme.subheadingStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppTheme.secondaryTextColor,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        place.location,
                        style: AppTheme.captionStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  place.description,
                  style: AppTheme.bodyStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${place.currency}${place.price.toStringAsFixed(0)}',
                      style: AppTheme.priceStyle,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${place.daysRecommended} days',
                        style: TextStyle(
                          color: AppTheme.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.close,
                      backgroundColor: Colors.red.shade100,
                      iconColor: Colors.red,
                      onTap: onUnlike,
                    ),
                    _buildActionButton(
                      icon: Icons.favorite,
                      backgroundColor: isLiked ? AppTheme.accentColor : Colors.green.shade100,
                      iconColor: isLiked ? Colors.white : Colors.green,
                      onTap: onLike,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }
} 