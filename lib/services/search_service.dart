import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rydo/apis/osm_api.dart';

class SearchService {
  Future<List<Map<String, dynamic>>> searchPlaces(String query) async {
    if (query.length < 3) return [];

    try {
      final response = await http.get(
        Uri.parse(
          '${OsmApi.geocodeUrl}?q=$query&format=json&addressdetails=1&limit=10',
        ),
        headers: {'User-Agent': OsmApi.userAgent},
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data
            .map(
              (item) {
                String displayName = item['display_name'] ?? "";
                String name = item['name'] ?? (displayName.split(',').first.isNotEmpty ? displayName.split(',').first : "Location");
                return {
                  'display_name': displayName,
                  'lat': item['lat'],
                  'lon': item['lon'],
                  'name': name,
                };
              },
            )
            .toList();
      }
    } catch (e) {
      log('Search error: $e');
    }
    return [];
  }

  // Simple nearby mock for demonstration if API doesn't support radius well without lat/lon
  Future<List<Map<String, String>>> getNearbySuggestions() async {
    // In a real app, you'd fetch based on current lat/lon
    return [
      {"name": "Current Location", "address": "Using GPS..."},
      {"name": "Set Location on Map", "address": "Pin your exact spot"},
    ];
  }
}
