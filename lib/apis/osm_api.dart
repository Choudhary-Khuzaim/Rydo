class OsmApi {
  // CartoDB Voyager - Much more reliable and cleaner for professional apps
  static const String tileUrl =
      'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png';

  // CartoDB Dark Matter - Professional for Dark Modes
  static const String darkTileUrl =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';

  // Fallback OSM URL if needed
  static const String osmFallbackUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // Nominatim Geocoding API (Search)
  static const String geocodeUrl = 'https://nominatim.openstreetmap.org/search';

  // Routing API (OSRM)
  static const String routingUrl = 'https://router.project-osrm.org/route/v1';

  // Professional User Agent
  static const String userAgent = 'RydoApp/1.0.0 (com.example.rydo)';

  // Map configuration constants
  static const double defaultZoom = 15.0;
  static const int minZoom = 2;
  static const int maxZoom = 19;
}
