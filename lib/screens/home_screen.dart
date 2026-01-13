import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rydo/services/location_service.dart';
import 'package:rydo/screens/search_screen.dart';
import 'package:rydo/widgets/ride_selection_sheet.dart';
import 'package:rydo/screens/finding_driver_screen.dart';
import 'package:rydo/screens/driver_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  final LocationService _locationService = LocationService();
  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool _showFarePanel = false;
  String? _destinationName;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _locationService.determinePosition();
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _markers.add(
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: _currentPosition!,
              infoWindow: const InfoWindow(title: 'My Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            ),
          );
        });
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _currentPosition!,
              zoom: 15,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _navigateToSearch() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );

    if (result != null && _currentPosition != null) {
      // Mocking coordinates for the selected result since we don't have Geocoding API
      // Creating a destination slightly offset from current location
      LatLng destination = LatLng(
        _currentPosition!.latitude + 0.01,
        _currentPosition!.longitude + 0.01,
      );

      setState(() {
        _destinationName = result;
        _showFarePanel = true;
        _markers.add(
          Marker(
            markerId: const MarkerId('destination'),
            position: destination,
            infoWindow: InfoWindow(title: result),
          ),
        );
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: [_currentPosition!, destination],
            color: Colors.black,
            width: 5,
          ),
        );
      });

      // Zoom to fit both markers
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          _currentPosition!.latitude < destination.latitude ? _currentPosition!.latitude : destination.latitude,
          _currentPosition!.longitude < destination.longitude ? _currentPosition!.longitude : destination.longitude,
        ),
        northeast: LatLng(
          _currentPosition!.latitude > destination.latitude ? _currentPosition!.latitude : destination.latitude,
          _currentPosition!.longitude > destination.longitude ? _currentPosition!.longitude : destination.longitude,
        ),
      );
      _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    }
  }

  void _onRideSelected(String rideType, double price) {
    // 1. Show Finding Driver Screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindingDriverScreen()),
    );

    // 2. Simulate delay then show Driver Details
    Future.delayed(const Duration(seconds: 4), () {
      // Check if user is still on the FindingDriverScreen (mostly true unless they cancelled)
      // For simplicity in this demo, we assume they didn't cancel for now, or we just push on top
      // A robust app would check logic.
      if (mounted) {
        Navigator.pop(context); // Pop Finding Driver
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DriverDetailsScreen()),
        ).then((_) {
          // When DriverDetails is popped (Finished/Cancelled), reset state
          setState(() {
            _showFarePanel = false;
            _destinationName = null;
            _polylines.clear();
            // keep current location marker
            _markers = {_markers.firstWhere((m) => m.markerId == const MarkerId('currentLocation'))};
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Rydo", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
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
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              // Set map style here if JSON is available
              if (_currentPosition != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _currentPosition!,
                      zoom: 15,
                    ),
                  ),
                );
              }
            },
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: false, // Custom button used
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            padding: EdgeInsets.only(bottom: _showFarePanel ? 350 : 0), // Adjust padding for taller sheet
          ),
           if (!_showFarePanel)
            Positioned(
              bottom: 30,
              right: 20,
              child: FloatingActionButton(
                onPressed: _getCurrentLocation,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 4,
                child: const Icon(Icons.my_location),
              ),
            ),
          if (!_showFarePanel)
            Positioned(
              top: 100, // Below AppBar
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: _navigateToSearch,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                       BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.blueAccent, size: 28),
                      SizedBox(width: 15),
                      Text(
                        "Where to go?",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                         child: Icon(Icons.arrow_forward, color: Colors.white, size: 16)
                      )
                    ],
                  ),
                ),
              ),
            ),
          if (_showFarePanel)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RideSelectionSheet(
                distanceDuration: const {"distance": 5, "duration": 15}, // mock
                onRideSelected: _onRideSelected,
              ),
            ),
        ],
      ),
    );
  }
}
