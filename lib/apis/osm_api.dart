class OsmApi {
  // OpenStreetMap Tile Server URL (Standard)
  static const String tileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // Nominatim Geocoding API (Search)
  static const String geocodeUrl = 'https://nominatim.openstreetmap.org/search';

  // Package name for OSM attribution (Required by OSM policy)
  // Matching the applicationId from build.gradle
  static const String userAgent = 'com.example.rydo';

  // Map configuration constants
  static const double defaultZoom = 15.0;
  static const int minZoom = 2;
  static const int maxZoom = 19;
}
