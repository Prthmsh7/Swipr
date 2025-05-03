# TravelSwipr - Android Travel Booking App

TravelSwipr is a Tinder-inspired travel booking Android application built with Jetpack Compose. The app allows users to browse through travel destinations and accommodations by swiping left (to reject) or right (to save/like) destinations.

## Features

- **Search by Budget and Days**: Users can input their budget and number of travel days to find suitable destinations.
- **Tinder-like Swiping Interface**: Swipe right to like a destination, left to reject it.
- **Saved Destinations**: View and manage all your liked destinations.
- **Modern UI**: Built with Jetpack Compose for a sleek, modern interface.
- **AI-Powered Recommendations**: Coming soon - AI sorting and recommendations based on preferences and budget (currently mocked with sample data).

## Application Structure

The application is structured following MVVM (Model-View-ViewModel) architecture:

### Data Layer
- `TravelPlace.kt`: Data model representing a travel destination or hotel.
- `TravelRepository.kt`: Repository managing travel data and liked places.

### ViewModel
- `TravelViewModel.kt`: Handles business logic and manages app state.

### UI Layer
- **Screens**:
  - `SearchScreen.kt`: Initial screen for inputting budget and travel days.
  - `SwipeScreen.kt`: Main screen for swiping through destinations.
  - `LikesScreen.kt`: Screen displaying saved/liked destinations.
  
- **Components**:
  - `PlaceCard.kt`: Component to display destination details.
  - `BottomNavBar.kt`: Navigation bar for moving between screens.

### Theme
- Custom theme with branded colors, typography, and shapes.

## Technical Details

- **Language**: Kotlin
- **UI Framework**: Jetpack Compose
- **Architecture**: MVVM
- **Image Loading**: Coil
- **Animation**: Compose Animation APIs for the swipe functionality
- **State Management**: Kotlin Flow and Compose State

## AI Integration (Coming Soon)

The application is designed to integrate with an AI service that will:
1. Sort and filter locations based on user preferences
2. Recommend destinations based on budget constraints
3. Learn from user swipe patterns to improve recommendations
4. Optimize travel itineraries for the specified number of days

Currently, the app uses sample data to demonstrate the UI and functionality.

## Future Enhancements

- Integration with a real travel API for live data
- User authentication
- Booking functionality
- Filtering and sorting options
- Map view of destinations
- AI-powered recommendations based on swipe history

## Getting Started

1. Clone this repository
2. Open the project in Android Studio
3. Build and run on an emulator or physical device

## Requirements

- Android Studio Arctic Fox or newer
- Minimum SDK: 24 (Android 7.0)
- Target SDK: 34 (Android 14)
