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

    // Only update address if we don't have one or if the position changed significantly
    // (Optimization: distance filter already handles some of this)
    if (_currentPosition == null ||
        Geolocator.distanceBetween(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              position.latitude,
              position.longitude,
            ) >
            100) {
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
          width: 80,
          height: 80,
          child: const Icon(
            Icons.location_history,
            color: Colors.blue,
            size: 40,
          ),
        );

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

    if (result != null && _currentPosition != null) {
      // Mocking coordinates for the selected result
      LatLng destination = LatLng(
        _currentPosition!.latitude + 0.01,
        _currentPosition!.longitude + 0.01,
      );

      setState(() {
        // _destinationName = result; // Removed
        _showFarePanel = true;
        _markers.add(
          Marker(
            point: destination,
            width: 80,
            height: 80,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );
        _polylines.add(
          Polyline(
            points: [_currentPosition!, destination],
            color: Colors.black,
            strokeWidth: 5,
          ),
        );
      });

      _mapController.move(
        LatLng(
          (_currentPosition!.latitude + destination.latitude) / 2,
          (_currentPosition!.longitude + destination.longitude) / 2,
        ),
        13,
      );
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text("John Doe"),
              accountEmail: Text("john.doe@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("JD", style: TextStyle(color: Colors.black)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Your Trips'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payment'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
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
                    // Reset markers to just current location if needed,
                    // but keeping it simple as per request "off ho jye"
                  });
                }
              },
              behavior:
                  HitTestBehavior.opaque, // Ensure it catches taps accurately
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentPosition ?? _kDefaultLocation,
                  initialZoom: 15,
                  onTap: (tapPosition, point) {
                    // Also handle map tap specifically if the GestureDetector above doesn't catch it
                    // due to FlutterMap consuming gestures.
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
                    urlTemplate: OsmApi.tileUrl,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Location Picker
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        _currentAddress,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Floating Search Bar
          if (!_showFarePanel)
            Positioned(
              bottom: 180, // Increased gap from bottom nav
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
                        color: Colors.white.withValues(alpha: 0.7),
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
                        children: const [
                          Icon(Icons.search, color: Colors.black54, size: 24),
                          SizedBox(width: 15),
                          Text(
                            "Where to go?",
                            style: TextStyle(
                              color: Colors.black54,
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
                distanceDuration: const {"distance": 5, "duration": 15},
                onRideSelected: _onRideSelected,
              ),
            ),

          // 5. My Location Button
          if (!_showFarePanel)
            Positioned(
              bottom: 260, // Above Search Bar
              right: 20,
              child: FloatingActionButton(
                mini: true,
                onPressed: _getCurrentLocation,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 4,
                child: _isLocating
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
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
