import 'dart:convert';
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
              (item) => {
                'display_name': item['display_name'],
                'lat': item['lat'],
                'lon': item['lon'],
                'name': item['name'] ?? item['display_name'].split(',')[0],
              },
            )
            .toList();
      }
    } catch (e) {
      print('Search error: $e');
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
