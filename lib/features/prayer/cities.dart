/// A small list of major cities so a location can be chosen without granting
/// location permission. Coordinates are approximate city centers; users can
/// enter exact coordinates instead.
class City {
  const City(this.name, this.latitude, this.longitude);
  final String name;
  final double latitude;
  final double longitude;
}

const cities = <City>[
  City('Makkah', 21.4225, 39.8262),
  City('Madinah', 24.4672, 39.6111),
  City('Riyadh', 24.7136, 46.6753),
  City('Dubai', 25.2048, 55.2708),
  City('Cairo', 30.0444, 31.2357),
  City('Istanbul', 41.0082, 28.9784),
  City('Karachi', 24.8607, 67.0011),
  City('Lahore', 31.5204, 74.3587),
  City('Islamabad', 33.6844, 73.0479),
  City('Delhi', 28.6139, 77.2090),
  City('Dhaka', 23.8103, 90.4125),
  City('Kuala Lumpur', 3.1390, 101.6869),
  City('Jakarta', -6.2088, 106.8456),
  City('London', 51.5074, -0.1278),
  City('Paris', 48.8566, 2.3522),
  City('Toronto', 43.6532, -79.3832),
  City('New York', 40.7128, -74.0060),
  City('Los Angeles', 34.0522, -118.2437),
  City('Sydney', -33.8688, 151.2093),
  City('Johannesburg', -26.2041, 28.0473),
];
