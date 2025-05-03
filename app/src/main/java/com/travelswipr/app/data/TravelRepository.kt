package com.travelswipr.app.data

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow

class TravelRepository {
    private val _likedPlaces = MutableStateFlow<List<TravelPlace>>(emptyList())
    val likedPlaces: Flow<List<TravelPlace>> = _likedPlaces

    fun likeTravelPlace(place: TravelPlace) {
        val currentList = _likedPlaces.value.toMutableList()
        if (!currentList.contains(place)) {
            currentList.add(place)
            _likedPlaces.value = currentList
        }
    }

    fun removeLikedPlace(place: TravelPlace) {
        val currentList = _likedPlaces.value.toMutableList()
        currentList.remove(place)
        _likedPlaces.value = currentList
    }

    fun getPlacesForBudgetAndDays(budget: Int, days: Int): List<TravelPlace> {
        // In a real app, this would filter based on the budget and days
        // For now, we'll return all sample places
        return getSampleTravelPlaces()
    }

    // Sample data for development
    private fun getSampleTravelPlaces(): List<TravelPlace> {
        return listOf(
            TravelPlace(
                id = "1",
                name = "Luxury Ocean View Resort",
                description = "Experience ultimate luxury with breathtaking ocean views. This 5-star resort offers world-class amenities including infinity pools, spa services, and gourmet dining options.",
                location = "Bali, Indonesia",
                price = 250,
                rating = 4.8f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1566073771259-6a8506099945",
                    "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4",
                    "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb"
                ),
                amenities = listOf("Pool", "Spa", "Restaurant", "Beach Access", "Free WiFi"),
                latitude = -8.409518,
                longitude = 115.188919
            ),
            TravelPlace(
                id = "2",
                name = "Mountain Retreat Cabin",
                description = "Escape to this cozy mountain cabin surrounded by pine forests. Perfect for nature lovers seeking peace and serenity with hiking trails and wildlife viewing.",
                location = "Aspen, Colorado",
                price = 175,
                rating = 4.5f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1470770841072-f978cf4d019e",
                    "https://images.unsplash.com/photo-1499696010180-025ef6e1a8f9",
                    "https://images.unsplash.com/photo-1501117716987-67454a23667d"
                ),
                amenities = listOf("Fireplace", "Hot Tub", "Mountain View", "Hiking Trails"),
                latitude = 39.1911,
                longitude = -106.8175
            ),
            TravelPlace(
                id = "3",
                name = "Urban Boutique Hotel",
                description = "This trendy boutique hotel in the heart of the city offers a perfect blend of comfort and style. Walking distance to major attractions, shopping, and dining.",
                location = "New York City, USA",
                price = 320,
                rating = 4.6f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1566665797739-1674de7a421a",
                    "https://images.unsplash.com/photo-1578683010236-d716f9a3f461",
                    "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa"
                ),
                amenities = listOf("Gym", "Rooftop Bar", "Room Service", "Business Center"),
                latitude = 40.7128,
                longitude = -74.0060
            ),
            TravelPlace(
                id = "4",
                name = "Tropical Beachfront Villa",
                description = "Private beachfront villa with stunning sunset views. Includes infinity pool, dedicated staff, and luxurious amenities for the perfect tropical getaway.",
                location = "Phuket, Thailand",
                price = 280,
                rating = 4.9f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1540541338287-41700207dee6",
                    "https://images.unsplash.com/photo-1540632998810-45157de552c5",
                    "https://images.unsplash.com/photo-1544881683-3b15e75e4143"
                ),
                amenities = listOf("Private Pool", "Beach Access", "Chef", "Butler", "Boat Tours"),
                latitude = 7.8804,
                longitude = 98.3923
            ),
            TravelPlace(
                id = "5",
                name = "Historic City Apartment",
                description = "Charming apartment in a renovated historic building with original features. Located in the old town with easy access to cultural sites and local cuisine.",
                location = "Prague, Czech Republic",
                price = 120,
                rating = 4.4f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1556912998-c57cc6b63cd7",
                    "https://images.unsplash.com/photo-1464146072230-91cabc968266",
                    "https://images.unsplash.com/photo-1553653924-39b70295f8da"
                ),
                amenities = listOf("WiFi", "Kitchen", "City View", "Washing Machine"),
                latitude = 50.0755,
                longitude = 14.4378
            ),
            TravelPlace(
                id = "6",
                name = "Desert Oasis Resort",
                description = "Luxury in the heart of the desert with traditional architecture and modern comforts. Experience camel rides, stargazing, and authentic cultural experiences.",
                location = "Dubai, UAE",
                price = 350,
                rating = 4.7f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1585293632079-36e9bd44ecdc",
                    "https://images.unsplash.com/photo-1528657291322-1a82c8c76886",
                    "https://images.unsplash.com/photo-1512100254544-47340ba56b5d"
                ),
                amenities = listOf("Pool", "Spa", "Desert Tours", "Restaurant", "Air Conditioning"),
                latitude = 25.2048,
                longitude = 55.2708
            ),
            TravelPlace(
                id = "7",
                name = "Lakeside Cottage",
                description = "Peaceful cottage on the shores of a pristine lake. Enjoy fishing, boating, and stunning sunsets from your private dock. Perfect for a relaxing retreat.",
                location = "Lake District, UK",
                price = 150,
                rating = 4.5f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1568389858085-50d5a7b36c0f",
                    "https://images.unsplash.com/photo-1499793983690-e29da59ef1c2",
                    "https://images.unsplash.com/photo-1502784444187-359ac186c5bb"
                ),
                amenities = listOf("Fireplace", "Lake Access", "BBQ", "Boats", "Fishing Gear"),
                latitude = 54.4609,
                longitude = -3.0886
            ),
            TravelPlace(
                id = "8",
                name = "Safari Lodge",
                description = "Authentic safari experience with luxury accommodations. Watch wildlife from your private terrace and enjoy guided tours led by experienced rangers.",
                location = "Serengeti, Tanzania",
                price = 420,
                rating = 4.9f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1493246507139-91e8fad9978e",
                    "https://images.unsplash.com/photo-1535941339077-2dd1c7963098",
                    "https://images.unsplash.com/photo-1516426122078-c23e76319801"
                ),
                amenities = listOf("Safari Tours", "Pool", "Restaurant", "Observation Deck"),
                latitude = -2.3333,
                longitude = 34.8333
            ),
            TravelPlace(
                id = "9",
                name = "Ski Chalet",
                description = "Charming ski-in/ski-out chalet with panoramic mountain views. Features a hot tub, sauna, and cozy fireplace for après-ski relaxation.",
                location = "Zermatt, Switzerland",
                price = 280,
                rating = 4.7f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1548777123-e216912df7d8",
                    "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa",
                    "https://images.unsplash.com/photo-1550184658-ff6132a71714"
                ),
                amenities = listOf("Ski-in/Ski-out", "Hot Tub", "Sauna", "Fireplace", "Boot Warmers"),
                latitude = 46.0207,
                longitude = 7.7491
            ),
            TravelPlace(
                id = "10",
                name = "Island Bungalow",
                description = "Overwater bungalow in a paradise island setting. Crystal clear waters, coral reefs, and ultimate privacy for a romantic getaway.",
                location = "Maldives",
                price = 550,
                rating = 5.0f,
                imageUrls = listOf(
                    "https://images.unsplash.com/photo-1516815231560-8f41ec531527",
                    "https://images.unsplash.com/photo-1503813477738-f0ba0240a0c3",
                    "https://images.unsplash.com/photo-1555274175-75f4056dfd05"
                ),
                amenities = listOf("Direct Ocean Access", "Glass Floor", "Private Deck", "Spa Services"),
                latitude = 3.2028,
                longitude = 73.2207
            )
        )
    }
} 