class TravelPlace {
  final String id;
  final String name;
  final String location;
  final String description;
  final double price;
  final int daysRecommended;
  final List<String> images;
  final double rating;
  final String currency;
  final String type; // New field to differentiate between destinations and hotels

  TravelPlace({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.daysRecommended,
    required this.images,
    required this.rating,
    this.currency = '\$',
    this.type = 'destination', // Default is destination
  });

  // Sample data generator for demo purposes
  static List<TravelPlace> getSamplePlaces() {
    return [
      // ===== DESTINATIONS =====
      TravelPlace(
        id: '1',
        name: 'Bali Beachfront Villa',
        location: 'Bali, Indonesia',
        description: 'Luxurious beachfront villa with private pool and stunning ocean views. Perfect for a relaxing getaway in tropical paradise.',
        price: 1200,
        daysRecommended: 7,
        images: [
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
          'https://images.unsplash.com/photo-1544644181-1484b3fdfc32',
          'https://images.unsplash.com/photo-1598881304348-089cd66931cd'
        ],
        rating: 4.8,
        type: 'hotel',
      ),
      TravelPlace(
        id: '2',
        name: 'Tokyo City Experience',
        location: 'Tokyo, Japan',
        description: 'Modern apartment in the heart of Tokyo. Experience the perfect blend of traditional and futuristic Japan with easy access to major attractions.',
        price: 950,
        daysRecommended: 5,
        images: [
          'https://images.unsplash.com/photo-1536098561742-ca998e48cbcc',
          'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
          'https://images.unsplash.com/photo-1542051841857-5f90071e7989'
        ],
        rating: 4.6,
        type: 'destination',
      ),
      TravelPlace(
        id: '3',
        name: 'Paris Romantic Getaway',
        location: 'Paris, France',
        description: 'Charming apartment with Eiffel Tower views. The perfect setting for a romantic getaway in the city of love. Walking distance to cafes and museums.',
        price: 1100,
        daysRecommended: 4,
        images: [
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
          'https://images.unsplash.com/photo-1522093007474-d86e9bf7ba6f',
          'https://images.unsplash.com/photo-1543349689-9a4d426bee8e'
        ],
        rating: 4.7,
        type: 'hotel',
      ),
      TravelPlace(
        id: '4',
        name: 'New York Skyline Suite',
        location: 'New York, USA',
        description: 'Luxury suite with panoramic views of the Manhattan skyline. Experience the energy of the city that never sleeps with premium amenities and services.',
        price: 1500,
        daysRecommended: 6,
        images: [
          'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
          'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb'
        ],
        rating: 4.9,
        type: 'hotel',
      ),
      TravelPlace(
        id: '5',
        name: 'Swiss Alps Chalet',
        location: 'Zermatt, Switzerland',
        description: 'Cozy mountain chalet with breathtaking views of the Alps. Perfect for skiing in winter or hiking in summer. Authentic Swiss experience.',
        price: 1300,
        daysRecommended: 8,
        images: [
          'https://images.unsplash.com/photo-1520466809213-7b9a56adcd45',
          'https://images.unsplash.com/photo-1527489377706-5bf97e608852',
          'https://images.unsplash.com/photo-1520466809559-22b231d75680'
        ],
        rating: 4.8,
        type: 'destination',
      ),
      // New additions
      TravelPlace(
        id: '6',
        name: 'Santorini Cliffside Villa',
        location: 'Santorini, Greece',
        description: 'Traditional Cycladic villa perched on the cliffs of Santorini with infinity pool overlooking the Aegean Sea. Famous for its stunning sunsets and white-washed buildings.',
        price: 1450,
        daysRecommended: 6,
        images: [
          'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff',
          'https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e',
          'https://images.unsplash.com/photo-1601581875039-e899893d520c'
        ],
        rating: 4.9,
        type: 'hotel',
      ),
      TravelPlace(
        id: '7',
        name: 'Kyoto Traditional Ryokan',
        location: 'Kyoto, Japan',
        description: 'Experience authentic Japanese culture in this centuries-old ryokan. Featuring tatami rooms, onsen baths, and traditional kaiseki dining in the historic Gion district.',
        price: 800,
        daysRecommended: 4,
        images: [
          'https://images.unsplash.com/photo-1528360983277-13d401cdc186',
          'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e',
          'https://images.unsplash.com/photo-1480796927426-f609979314bd'
        ],
        rating: 4.7,
        type: 'hotel',
      ),
      TravelPlace(
        id: '8',
        name: 'Maldives Overwater Bungalow',
        location: 'Malé, Maldives',
        description: 'Luxurious overwater bungalow with direct access to crystal-clear turquoise waters. Private deck, glass floor sections, and unparalleled marine life views.',
        price: 2200,
        daysRecommended: 7,
        images: [
          'https://images.unsplash.com/photo-1516815231560-8f41ec531527',
          'https://images.unsplash.com/photo-1514282401047-d79a71a590e8',
          'https://images.unsplash.com/photo-1573843981267-be1999ff37cd'
        ],
        rating: 5.0,
        type: 'hotel',
      ),
      TravelPlace(
        id: '9',
        name: 'Amazon Rainforest Eco Lodge',
        location: 'Manaus, Brazil',
        description: 'Sustainable eco-lodge nestled in the heart of the Amazon rainforest. Guided jungle treks, wildlife spotting, and indigenous cultural experiences included.',
        price: 1100,
        daysRecommended: 5,
        images: [
          'https://images.unsplash.com/photo-1518182170546-07661fd94144',
          'https://images.unsplash.com/photo-1572902101785-4e6b50a491e2',
          'https://images.unsplash.com/photo-1551256097-46d13dfed264'
        ],
        rating: 4.5,
        type: 'destination',
      ),
      TravelPlace(
        id: '10',
        name: 'Marrakech Riad & Spa',
        location: 'Marrakech, Morocco',
        description: 'Traditional Moroccan riad featuring a central courtyard with fountain, rooftop terrace with Atlas Mountain views, and authentic hammam spa experience.',
        price: 780,
        daysRecommended: 5,
        images: [
          'https://images.unsplash.com/photo-1548759806-821c48c47dbc',
          'https://images.unsplash.com/photo-1539037116277-4db20889f2d4',
          'https://images.unsplash.com/photo-1603460689491-5a1281a1e05b'
        ],
        rating: 4.6,
        type: 'hotel',
      ),
      TravelPlace(
        id: '11',
        name: 'Tuscany Vineyard Estate',
        location: 'Florence, Italy',
        description: 'Stunning 16th-century villa surrounded by vineyards and olive groves in the rolling hills of Tuscany. Wine tastings, cooking classes, and panoramic countryside views.',
        price: 1350,
        daysRecommended: 6,
        images: [
          'https://images.unsplash.com/photo-1523531294919-4bcd7c65e216',
          'https://images.unsplash.com/photo-1568124951449-22ec2e21ee22',
          'https://images.unsplash.com/photo-1533932265761-eb0cabbc8e13'
        ],
        rating: 4.8,
        type: 'destination',
      ),
      TravelPlace(
        id: '12',
        name: 'Northern Lights Igloo',
        location: 'Rovaniemi, Finland',
        description: 'Glass-roofed igloo offering unobstructed views of the Arctic sky and Northern Lights. Heated accommodation with modern amenities in a magical winter wonderland.',
        price: 950,
        daysRecommended: 4,
        images: [
          'https://images.unsplash.com/photo-1520681279154-51b3fb4ea0f4',
          'https://images.unsplash.com/photo-1529350178847-e04ef322dd19',
          'https://images.unsplash.com/photo-1559592892-eda7025338bf'
        ],
        rating: 4.9,
        type: 'destination',
      ),
      TravelPlace(
        id: '13',
        name: 'Dubai Luxury Penthouse',
        location: 'Dubai, UAE',
        description: 'Ultra-luxurious penthouse with panoramic views of the Dubai skyline, private pool, and exclusive access to 5-star amenities. Located in the iconic Burj district.',
        price: 2500,
        daysRecommended: 5,
        images: [
          'https://images.unsplash.com/photo-1550490754-8ea91e3d8929',
          'https://images.unsplash.com/photo-1582653291997-079b4f1cf738',
          'https://images.unsplash.com/photo-1512453979798-5ea266f8880c'
        ],
        rating: 4.9,
        type: 'hotel',
      ),
      TravelPlace(
        id: '14',
        name: 'Cape Town Ocean Villa',
        location: 'Cape Town, South Africa',
        description: 'Contemporary villa overlooking the Atlantic Ocean with Table Mountain as backdrop. Infinity pool, private beach access, and proximity to vineyards and safari opportunities.',
        price: 1200,
        daysRecommended: 7,
        images: [
          'https://images.unsplash.com/photo-1580060839134-75a5edca2e99',
          'https://images.unsplash.com/photo-1594398537905-3a907119ae64',
          'https://images.unsplash.com/photo-1577296627214-7bc62e6e9d02'
        ],
        rating: 4.7,
        type: 'destination',
      ),
      TravelPlace(
        id: '15',
        name: 'Amalfi Coast Seaside Villa',
        location: 'Positano, Italy',
        description: 'Pastel-colored villa clinging to the cliffs of the Amalfi Coast with panoramic Mediterranean views. Terraced gardens, authentic Italian design, and private boat dock.',
        price: 1700,
        daysRecommended: 6,
        images: [
          'https://images.unsplash.com/photo-1533676802871-eca1ae998cd5',
          'https://images.unsplash.com/photo-1591604021695-0c69b7c05981',
          'https://images.unsplash.com/photo-1539683867645-485144c6ad6d'
        ],
        rating: 4.9,
        type: 'hotel',
      ),
    ];
  }
} 