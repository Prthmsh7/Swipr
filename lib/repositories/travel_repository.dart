import 'package:flutter/foundation.dart';
import '../models/travel_place.dart';

class TravelRepository with ChangeNotifier {
  final List<TravelPlace> _allPlaces = TravelPlace.getSamplePlaces();
  final List<TravelPlace> _likedPlaces = [];
  
  // Budget and days filter
  double _budget = 0;
  int _days = 0;
  String _selectedType = 'all'; // 'all', 'hotel', or 'destination'
  
  // Getters
  List<TravelPlace> get allPlaces => _allPlaces;
  List<TravelPlace> get likedPlaces => _likedPlaces;
  double get budget => _budget;
  int get days => _days;
  String get selectedType => _selectedType;
  
  // Filtered places based on budget, days, and type
  List<TravelPlace> get filteredPlaces {
    if (_budget <= 0 || _days <= 0) {
      return _selectedType == 'all' 
          ? _allPlaces 
          : _allPlaces.where((place) => place.type == _selectedType).toList();
    }
    
    return _allPlaces.where((place) {
      bool budgetAndDaysMatch = place.price <= _budget && place.daysRecommended <= _days;
      
      if (_selectedType == 'all') {
        return budgetAndDaysMatch;
      } else {
        return budgetAndDaysMatch && place.type == _selectedType;
      }
    }).toList();
  }
  
  // Get hotels only
  List<TravelPlace> get hotels {
    return _allPlaces.where((place) => place.type == 'hotel').toList();
  }
  
  // Get destinations only
  List<TravelPlace> get destinations {
    return _allPlaces.where((place) => place.type == 'destination').toList();
  }
  
  // Set budget and days
  void setBudgetAndDays(double budget, int days) {
    _budget = budget;
    _days = days;
    notifyListeners();
  }
  
  // Set selected type filter
  void setSelectedType(String type) {
    if (type == 'all' || type == 'hotel' || type == 'destination') {
      _selectedType = type;
      notifyListeners();
    }
  }
  
  // Like a place
  void likePlace(TravelPlace place) {
    if (!_likedPlaces.contains(place)) {
      _likedPlaces.add(place);
      notifyListeners();
    }
  }
  
  // Remove a place from liked
  void unlikePlace(TravelPlace place) {
    _likedPlaces.remove(place);
    notifyListeners();
  }
} 