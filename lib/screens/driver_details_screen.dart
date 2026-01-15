import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rydo/apis/osm_api.dart';
import 'package:rydo/screens/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rydo/services/route_service.dart';

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({super.key});

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  final MapController _mapController = MapController();
  final String _status = "Arriving in 4 minutes";
  final double _progress = 0.7;
  final int _state = 0; // 0: Arriving, 1: Arrived, 2: In Progress, 3: Completed

  // Mock driver and user locations in Karachi
  final LatLng _driverLocation = const LatLng(24.8607, 67.0011);
  final LatLng _userLocation = const LatLng(24.8716, 67.0599);

  // Points will be updated dynamically
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final points = await RouteService().getRoute(
      _driverLocation,
      _userLocation,
    );
    if (mounted) {
      setState(() {
        _routePoints = points;
      });
      _fitMapToMarkers();
    }
  }

  void _fitMapToMarkers() {
    if (_routePoints.isEmpty) return;
    final bounds = LatLngBounds.fromPoints(_routePoints);
    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(100)),
    );
  }

  Future<void> _makeCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: '03001234567');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 1. Live Map Background
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _driverLocation,
                initialZoom: 14,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: isDark ? OsmApi.darkTileUrl : OsmApi.tileUrl,
                  subdomains: const ['a', 'b', 'c', 'd'],
                  userAgentPackageName: OsmApi.userAgent,
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: isDark
                          ? Colors.blueAccent
                          : Colors.black.withValues(alpha: 0.8),
                      strokeWidth: 4,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _driverLocation,
                      width: 60,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.blueAccent : Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.directions_car_filled,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    Marker(
                      point: _userLocation,
                      width: 45,
                      height: 45,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.blueAccent.withValues(alpha: 0.2)
                                  : Colors.blue.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: isDark ? Colors.blueAccent : Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Custom Top Navigation Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [Colors.black, Colors.black.withValues(alpha: 0)]
                      : [Colors.white, Colors.white.withValues(alpha: 0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48), // Placeholder to center title
                    Text(
                      "En Route",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. Driver Details Card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 40,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Driver Info Section
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? Colors.grey[900]!
                                : Colors.grey[100]!,
                            width: 4,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/32.jpg",
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Michael D.",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "4.9",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                Text(
                                  " (2.5k trips)",
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Toyota Camry",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          Text(
                            "ABC 1234",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white38 : Colors.grey[400],
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          Icons.chat_bubble_rounded,
                          "Message",
                          isDark
                              ? const Color(0xFF1E1E1E)
                              : const Color(0xFFE3F2FD),
                          isDark ? Colors.blueAccent : Colors.blue[700]!,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChatScreen(driverName: "Michael D."),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionButton(
                          Icons.phone_rounded,
                          "Call",
                          isDark
                              ? const Color(0xFF1E1E1E)
                              : const Color(0xFFE8F5E9),
                          isDark ? Colors.greenAccent : Colors.green[700]!,
                          onTap: _makeCall,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Divider(
                    height: 1,
                    color: isDark ? Colors.grey[900] : Colors.grey[200],
                  ),
                  const SizedBox(height: 24),

                  // Arrival Progress Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _status,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      if (_state < 2)
                        Icon(
                          Icons.more_horiz_rounded,
                          color: isDark ? Colors.white24 : Colors.black26,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[900] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 6,
                        width:
                            MediaQuery.of(context).size.width * 0.8 * _progress,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.blueAccent : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
