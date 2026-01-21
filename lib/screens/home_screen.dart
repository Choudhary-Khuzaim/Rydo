import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rydo/services/location_service.dart';
import 'package:rydo/screens/search_screen.dart';
import 'package:rydo/widgets/ride_selection_sheet.dart';
import 'package:rydo/screens/finding_driver_screen.dart';
import 'package:rydo/screens/driver_details_screen.dart';
import 'package:rydo/apis/osm_api.dart';
import 'package:rydo/services/route_service.dart';
import 'package:rydo/screens/trips_screen.dart';
import 'package:rydo/screens/wallet_screen.dart';
import 'package:rydo/screens/account_screen.dart';
import 'package:rydo/database/mongodb.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();
  LatLng? _currentPosition;
  String _currentAddress = "San Francisco";
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];
  bool _showFarePanel = false;
  bool _isLocating = false;
  StreamSubscription<Position>? _positionSubscription;
  Map<String, int> _distanceDuration = {"distance": 5, "duration": 15};

  static const LatLng _kDefaultLocation = LatLng(
    37.42796133580664,
    -122.085749655962,
  );

  @override
  void initState() {
    super.initState();
    _markers = [];
    _polylines = [];
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startLocationUpdates() async {
    setState(() => _isLocating = true);
    try {
      // Ensure permissions and get initial position
      Position position = await _locationService.determinePosition();
      _updateUserMarker(position);
      _mapController.move(_currentPosition!, 15);

      // Start listening for live updates
      _positionSubscription = _locationService.getPositionStream().listen((
        position,
      ) {
        if (mounted) {
          _updateUserMarker(position);
        }
      });

      if (mounted) setState(() => _isLocating = false);
    } catch (e) {
      debugPrint("Location Error: $e");
      if (mounted) {
        setState(() => _isLocating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location Error: ${e.toString()}")),
        );
      }
    }
  }

  void _updateUserMarker(Position position) async {
    final latLng = LatLng(position.latitude, position.longitude);

    if (_currentPosition == null ||
        Geolocator.distanceBetween(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              position.latitude,
              position.longitude,
            ) >
            50) {
      String address = await _locationService.getAddressFromLatLng(
        position.latitude,
        position.longitude,
      );
      if (mounted) {
        setState(() {
          _currentAddress = address;
        });
      }
    }

    if (mounted) {
      setState(() {
        _currentPosition = latLng;

        // Update or add the user location marker
        final userMarker = Marker(
          point: _currentPosition!,
          width: 60,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.navigation_rounded,
                color: Colors.blue,
                size: 25,
              ),
            ),
          ),
        );

        if (_showFarePanel) {
          // If showing route, we might want to update user position
          // but not necessarily replace the first marker which is now the pickup
          // For now, let's just skip user marker update when route is visible
          // or we can manage a separate list.
          return;
        }

        if (_markers.isEmpty) {
          _markers.add(userMarker);
        } else {
          _markers[0] = userMarker;
        }
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    // If we already have a position, just move back to it
    if (_currentPosition != null) {
      _mapController.move(_currentPosition!, 15);
    } else {
      await _startLocationUpdates();
    }
  }

  Future<void> _navigateToSearch() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );

    if (result != null && result is Map) {
      final pickup = result['pickup'];
      final dropoff = result['dropoff'];

      if (dropoff != null) {
        final double destLat = dropoff['lat'] != 0.0
            ? dropoff['lat']
            : (_currentPosition?.latitude ?? _kDefaultLocation.latitude) + 0.01;
        final double destLon = dropoff['lon'] != 0.0
            ? dropoff['lon']
            : (_currentPosition?.longitude ?? _kDefaultLocation.longitude) +
                  0.01;

        LatLng destination = LatLng(destLat, destLon);

        // Handle custom pickup if provided, else use current
        LatLng pickupPoint = _currentPosition ?? _kDefaultLocation;
        if (pickup != null && pickup['lat'] != 0.0) {
          pickupPoint = LatLng(pickup['lat'], pickup['lon']);
        }

        setState(() {
          _showFarePanel = true;
          _markers.clear();
          _polylines.clear(); // Clear old routes
        });

        // Add Pickup & Dest Markers immediately
        setState(() {
          _markers.add(
            Marker(
              point: pickupPoint,
              width: 80,
              height: 80,
              child: const Icon(Icons.circle, color: Colors.blue, size: 20),
            ),
          );
          _markers.add(
            Marker(
              point: destination,
              width: 80,
              height: 80,
              child: const Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          );
        });

        // Fetch real route
        final List<LatLng> routePoints = await RouteService().getRoute(
          pickupPoint,
          destination,
        );

        if (mounted) {
          double totalDist = 0;
          for (int i = 0; i < routePoints.length - 1; i++) {
            totalDist += Geolocator.distanceBetween(
              routePoints[i].latitude,
              routePoints[i].longitude,
              routePoints[i + 1].latitude,
              routePoints[i + 1].longitude,
            );
          }
          double distanceKm = totalDist / 1000;
          int durationMins = (distanceKm * 2.5).round(); // ~24km/h avg
          if (durationMins < 3) durationMins = 3;

          setState(() {
            _distanceDuration = {
              "distance": distanceKm.round(),
              "duration": durationMins,
            };
            _polylines.add(
              Polyline(
                points: routePoints,
                color: Colors.black,
                strokeWidth: 5,
              ),
            );
          });

          // Zoom to fit the entire route
          final bounds = LatLngBounds.fromPoints(routePoints);
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.all(100),
            ),
          );
        }
      }
    }
  }

  void _onRideSelected(String rideType, double price) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindingDriverScreen()),
    );

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pop(context); // Pop Finding Driver
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DriverDetailsScreen()),
        ).then((_) {
          setState(() {
            _showFarePanel = false;
            // _destinationName = null; // Removed
            _polylines.clear();
            if (_currentPosition != null) {
              _markers = [
                Marker(
                  point: _currentPosition!,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              ];
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: isDark ? Colors.blueAccent : Colors.black,
              ),
              accountName: Text(MongoDatabase.currentUser?["name"] ?? "User"),
              accountEmail: Text(
                MongoDatabase.currentUser?["email"] ?? "user@example.com",
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: isDark ? Colors.black : Colors.white,
                child: Text(
                  (MongoDatabase.currentUser?["name"] ?? "U")
                      .substring(0, 1)
                      .toUpperCase(),
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Your Trips'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TripsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payment'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WalletScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // 1. Map Layer
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (_showFarePanel) {
                  setState(() {
                    _showFarePanel = false;
                    _polylines.clear();
                  });
                }
              },
              behavior: HitTestBehavior.opaque,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentPosition ?? _kDefaultLocation,
                  initialZoom: 15,
                  onTap: (tapPosition, point) {
                    if (_showFarePanel) {
                      setState(() {
                        _showFarePanel = false;
                        _polylines.clear();
                      });
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: isDark ? OsmApi.darkTileUrl : OsmApi.tileUrl,
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName: OsmApi.userAgent,
                  ),
                  PolylineLayer(polylines: _polylines),
                  MarkerLayer(markers: _markers),
                ],
              ),
            ),
          ),

          // 2. Custom Top Navigation Bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // Menu Button
                Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.menu,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                // Location Picker
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: Text(
                          _currentAddress,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: Theme.of(
                          context,
                        ).iconTheme.color?.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 48), // Spacer for balance
              ],
            ),
          ),

          // 3. Floating Search Bar
          if (!_showFarePanel)
            Positioned(
              bottom: 180,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: _navigateToSearch,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: 65,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: isDark ? Colors.white70 : Colors.black54,
                            size: 24,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Where to go?",
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // 4. Ride Selection Sheet (when active)
          if (_showFarePanel)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RideSelectionSheet(
                distanceDuration: _distanceDuration,
                onRideSelected: _onRideSelected,
              ),
            ),

          // 5. My Location Button
          if (!_showFarePanel)
            Positioned(
              bottom: 260,
              right: 20,
              child: FloatingActionButton(
                mini: true,
                onPressed: _getCurrentLocation,
                backgroundColor: Theme.of(context).cardColor,
                foregroundColor: isDark ? Colors.white : Colors.black,
                elevation: 4,
                child: _isLocating
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      )
                    : const Icon(Icons.my_location, size: 20),
              ),
            ),
        ],
      ),
    );
  }
}
