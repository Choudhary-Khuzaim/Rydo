import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rydo/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final SearchService _searchService = SearchService();

  Map<String, dynamic>? _selectedPickup;
  Map<String, dynamic>? _selectedDropoff;

  List<Map<String, dynamic>> _suggestions = [];
  bool _isLoading = false;
  Timer? _debounce;
  bool _isPickupFocused = false;

  final List<Map<String, String>> _nearbyMocks = [
    {
      "name": "Current Location",
      "address": "Tap to use GPS",
      "icon": "my_location",
    },
    {
      "name": "Set Location on Map",
      "address": "Pin your spot manually",
      "icon": "map",
    },
    {
      "name": "Dolmen Mall Clifton",
      "address": "Marine Drive, Karachi",
      "icon": "location_on",
    },
    {
      "name": "Lucky One Mall",
      "address": "Rashid Minhas Rd, Karachi",
      "icon": "location_on",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pickupController.addListener(_onSearchChanged);
    _dropoffController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _isPickupFocused
          ? _pickupController.text
          : _dropoffController.text;
      if (query.isNotEmpty) {
        _performSearch(query);
      } else {
        setState(() {
          _suggestions = [];
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() => _isLoading = true);
    final results = await _searchService.searchPlaces(query);
    if (mounted) {
      setState(() {
        _suggestions = results;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputSection(),
                  const SizedBox(height: 20),
                  _buildRideSelectButton(),
                  const SizedBox(height: 32),
                  if (_suggestions.isEmpty && !_isLoading) ...[
                    _buildSectionLabel(
                      _isPickupFocused ? "NEARBY SUGGESTIONS" : "SAVED PLACES",
                    ),
                    const SizedBox(height: 16),
                    if (_isPickupFocused)
                      ..._nearbyMocks.map((loc) => _buildNearbyItem(loc))
                    else
                      _buildSavedPlaces(),
                  ] else if (_isLoading) ...[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (_suggestions.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final location = _suggestions[index];
                  return _buildLocationItem(
                    location['name'] ?? "Location",
                    location['display_name'] ?? "",
                    lat: double.tryParse(location['lat']?.toString() ?? ""),
                    lon: double.tryParse(location['lon']?.toString() ?? ""),
                  );
                }, childCount: _suggestions.length),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildRideSelectButton() {
    bool isEnabled =
        _pickupController.text.isNotEmpty && _dropoffController.text.isNotEmpty;

    return GestureDetector(
      onTap: isEnabled
          ? () {
              Navigator.pop(context, {
                'pickup': _selectedPickup,
                'dropoff': _selectedDropoff,
              });
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: isEnabled ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: const Center(
          child: Text(
            "See Available Rides",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _onLocationSelected(Map<String, dynamic> location) {
    setState(() {
      if (_isPickupFocused) {
        _selectedPickup = location;
        _pickupController.text = location['name'] ?? "";
      } else {
        _selectedDropoff = location;
        _dropoffController.text = location['name'] ?? "";
      }
      _suggestions = [];
    });
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 60, bottom: 20),
        title: const Text(
          "Plan your ride",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Color(0xFF2D2D2D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                bottom: -30,
                child: Icon(
                  Icons.search_rounded,
                  size: 160,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Focus(
            onFocusChange: (f) => setState(() => _isPickupFocused = f),
            child: _buildSearchField(
              controller: _pickupController,
              hint: "Pickup location",
              icon: Icons.circle,
              iconColor: Colors.blue,
              isPickup: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 1.5, height: 20, color: Colors.black12),
            ),
          ),
          Focus(
            onFocusChange: (f) => setState(() => _isPickupFocused = !f),
            child: _buildSearchField(
              controller: _dropoffController,
              hint: "Where to?",
              icon: Icons.location_on_rounded,
              iconColor: Colors.black,
              isPickup: false,
              autoFocus: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required bool isPickup,
    bool autoFocus = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: isPickup ? 12 : 24),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: autoFocus,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        if (controller.text.isNotEmpty)
          GestureDetector(
            onTap: () => controller.clear(),
            child: Icon(Icons.close_rounded, color: Colors.grey[300], size: 20),
          ),
        if (!isPickup)
          const Icon(
            Icons.favorite_border_rounded,
            color: Colors.black26,
            size: 20,
          ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: Colors.grey[500],
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildNearbyItem(Map<String, String> loc) {
    IconData icon;
    switch (loc['icon']) {
      case 'my_location':
        icon = Icons.my_location;
        break;
      case 'map':
        icon = Icons.map_rounded;
        break;
      default:
        icon = Icons.location_on_outlined;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          loc['name']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          loc['address']!,
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
        onTap: () => _onLocationSelected({
          'name': loc['name'],
          'address': loc['address'],
          // In a real app, you'd get actual lat/lon for these mocks
          'lat': 0.0,
          'lon': 0.0,
        }),
      ),
    );
  }

  Widget _buildSavedPlaces() {
    return Row(
      children: [
        _buildSavedItem(Icons.home_rounded, "Home", "Defense Phase 6"),
        const SizedBox(width: 16),
        _buildSavedItem(Icons.work_rounded, "Work", "I.I Chundrigar Rd"),
      ],
    );
  }

  Widget _buildSavedItem(IconData icon, String label, String sub) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onLocationSelected({'name': label, 'address': sub}),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.black, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      sub,
                      style: TextStyle(color: Colors.grey[400], fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationItem(
    String name,
    String address, {
    double? lat,
    double? lon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.location_on_outlined, color: Colors.black87),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          address,
          style: TextStyle(color: Colors.grey[500], fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () => _onLocationSelected({
          'name': name,
          'address': address,
          'lat': lat ?? 0.0,
          'lon': lon ?? 0.0,
        }),
      ),
    );
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
