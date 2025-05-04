import 'package:flutter/foundation.dart';
import '../models/travel_place.dart';
import '../repositories/travel_repository.dart';

class TravelViewModel with ChangeNotifier {
  final TravelRepository _repository;

  TravelViewModel(this._repository);

  // Getters that pass through to repository
  List<TravelPlace> get allPlaces => _repository.allPlaces;
  List<TravelPlace> get likedPlaces => _repository.likedPlaces;
  List<TravelPlace> get filteredPlaces => _repository.filteredPlaces;
  List<TravelPlace> get hotels => _repository.hotels;
  List<TravelPlace> get destinations => _repository.destinations;
  double get budget => _repository.budget;
  int get days => _repository.days;
  String get selectedType => _repository.selectedType;

  // Set budget and days
  void setBudgetAndDays(double budget, int days) {
    _repository.setBudgetAndDays(budget, days);
  }

  // Set filter type
  void setSelectedType(String type) {
    _repository.setSelectedType(type);
  }

  // Like a place
  void likePlace(TravelPlace place) {
    _repository.likePlace(place);
  }

  // Unlike a place
  void unlikePlace(TravelPlace place) {
    _repository.unlikePlace(place);
  }

  // Check if a place is liked
  bool isPlaceLiked(TravelPlace place) {
    return _repository.likedPlaces.contains(place);
  }

  // Swipe right action
  void swipeRight(TravelPlace place) {
    likePlace(place);
  }

  // Swipe left action
  void swipeLeft(TravelPlace place) {
    // Do nothing for now, could log for analytics in the future
  }
} 