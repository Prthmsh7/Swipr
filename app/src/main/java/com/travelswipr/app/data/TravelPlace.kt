package com.travelswipr.app.data

data class TravelPlace(
    val id: String,
    val name: String,
    val description: String,
    val location: String,
    val price: Int,
    val rating: Float,
    val imageUrls: List<String>,
    val amenities: List<String>,
    val latitude: Double,
    val longitude: Double
) 