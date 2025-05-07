# TravelSwipr - Flutter Travel Booking App

TravelSwipr is a Tinder-inspired travel booking Flutter application for Android. The app allows users to browse through travel destinations and accommodations by swiping left (to reject) or right (to save/like) destinations.

## Features

- **Search by Budget and Days**: Users can input their budget and number of travel days to find suitable destinations.
- **Tinder-like Swiping Interface**: Swipe right to like a destination, left to reject it.
- **Saved Destinations**: View and manage all your liked destinations.
- **Modern UI**: Built with Flutter for a sleek, responsive interface.
- **Sample Data**: Currently uses sample data to demonstrate functionality (can be connected to a real API in the future).

## Application Structure

The application is structured following MVVM (Model-View-ViewModel) architecture:

### Data Layer
- `TravelPlace.dart`: Data model representing a travel destination or hotel.
- `TravelRepository.dart`: Repository managing travel data and liked places.

### ViewModel
- `TravelViewModel.dart`: Handles business logic and manages app state.

### UI Layer
- **Screens**:
  - `SearchScreen.dart`: Initial screen for inputting budget and travel days.
  - `SwipeScreen.dart`: Main screen for swiping through destinations.
  - `LikesScreen.dart`: Screen displaying saved/liked destinations.
  
- **Components**:
  - `PlaceCard.dart`: Component to display destination details.
  - `BottomNavBar.dart`: Navigation bar for moving between screens.

### Theme
- Custom theme with branded colors, typography, and shapes.

## Technical Details

- **Language**: Dart
- **Framework**: Flutter
- **Architecture**: MVVM
- **State Management**: Provider
- **Image Loading**: Cached Network Image
- **Animation**: Flutter Card Swiper and Flutter Staggered Animations
  
## Future Enhancements

- Integration with a real travel API for live data
- User authentication
- Booking functionality
- Additional filtering and sorting options
- Map view of destinations
- AI-powered recommendations based on swipe history

## Getting Started

1. Clone this repository
2. Make sure you have Flutter installed
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app on your emulator or connected device

## Requirements

- Flutter SDK
- Android Studio / VS Code
- Android emulator or physical device
