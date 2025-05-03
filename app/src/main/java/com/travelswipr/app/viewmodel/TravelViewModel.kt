package com.travelswipr.app.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.travelswipr.app.data.TravelPlace
import com.travelswipr.app.data.TravelRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class TravelViewModel : ViewModel() {
    private val repository = TravelRepository()
    
    // Current search parameters
    private val _budget = MutableStateFlow(0)
    val budget: StateFlow<Int> = _budget
    
    private val _days = MutableStateFlow(0)
    val days: StateFlow<Int> = _days
    
    // Travel places to swipe through
    private val _travelPlaces = MutableStateFlow<List<TravelPlace>>(emptyList())
    val travelPlaces: StateFlow<List<TravelPlace>> = _travelPlaces
    
    // Liked places
    private val _likedPlaces = MutableStateFlow<List<TravelPlace>>(emptyList())
    val likedPlaces: StateFlow<List<TravelPlace>> = _likedPlaces
    
    // Current place being viewed
    private val _currentPlaceIndex = MutableStateFlow(0)
    val currentPlaceIndex: StateFlow<Int> = _currentPlaceIndex
    
    init {
        // Observe liked places from repository
        viewModelScope.launch {
            repository.likedPlaces.collect { places ->
                _likedPlaces.value = places
            }
        }
    }
    
    fun updateBudget(budget: Int) {
        _budget.value = budget
    }
    
    fun updateDays(days: Int) {
        _days.value = days
    }
    
    fun searchPlaces() {
        val places = repository.getPlacesForBudgetAndDays(_budget.value, _days.value)
        _travelPlaces.value = places
        _currentPlaceIndex.value = 0
    }
    
    fun likeCurrentPlace() {
        getCurrentPlace()?.let { place ->
            repository.likeTravelPlace(place)
            moveToNextPlace()
        }
    }
    
    fun dislikeCurrentPlace() {
        moveToNextPlace()
    }
    
    fun removeLikedPlace(place: TravelPlace) {
        repository.removeLikedPlace(place)
    }
    
    private fun getCurrentPlace(): TravelPlace? {
        return if (_travelPlaces.value.isNotEmpty() && _currentPlaceIndex.value < _travelPlaces.value.size) {
            _travelPlaces.value[_currentPlaceIndex.value]
        } else {
            null
        }
    }
    
    private fun moveToNextPlace() {
        if (_currentPlaceIndex.value < _travelPlaces.value.size - 1) {
            _currentPlaceIndex.value = _currentPlaceIndex.value + 1
        }
    }
} 