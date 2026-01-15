import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:rydo/apis/osm_api.dart';

class RouteService {
  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url =
        '${OsmApi.routingUrl}/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coordinates =
            data['routes'][0]['geometry']['coordinates'];

        return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
      } else {
        return [start, end]; // Fallback to straight line
      }
    } catch (e) {
      return [start, end]; // Fallback to straight line
    }
  }
}
