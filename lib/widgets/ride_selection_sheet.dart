import 'package:flutter/material.dart';

class RideSelectionSheet extends StatefulWidget {
  final Map<String, int> distanceDuration; // {distance(km), duration(mins)}
  final Function(String, double) onRideSelected; // return type, price

  const RideSelectionSheet({
    super.key,
    required this.distanceDuration,
    required this.onRideSelected,
  });

  @override
  State<RideSelectionSheet> createState() => _RideSelectionSheetState();
}

class _RideSelectionSheetState extends State<RideSelectionSheet> {
  int _selectedIndex = 0;
  String _selectedCategory = "All";
  bool _isBooking = false;

  final List<String> _categories = ["All", "Economy", "Premium", "Bikes"];

  final List<Map<String, dynamic>> _rideOptions = [
    {
      "id": "bike",
      "name": "Rydo Bike",
      "desc": "Quickest for city traffic",
      "basePrice": 22.0,
      "multiplier": 0.6,
      "image": Icons.two_wheeler_rounded,
      "color": Colors.green,
      "eta": "1 min",
      "category": "Bikes",
      "seats": "1",
    },
    {
      "id": "mini",
      "name": "Rydo Mini",
      "desc": "Affordable, quick rides",
      "basePrice": 35.0,
      "multiplier": 1.0,
      "image": Icons.directions_car_rounded,
      "color": Colors.blue,
      "eta": "4 min",
      "category": "Economy",
      "seats": "4",
    },
    {
      "id": "go",
      "name": "Rydo Go",
      "desc": "Comfortable sedans",
      "basePrice": 45.0,
      "multiplier": 1.2,
      "image": Icons.local_taxi_rounded,
      "color": Colors.black,
      "eta": "2 min",
      "category": "Economy",
      "seats": "4",
    },
    {
      "id": "business",
      "name": "Business",
      "desc": "High-end luxury cars",
      "basePrice": 85.0,
      "multiplier": 2.0,
      "image": Icons.airport_shuttle_rounded,
      "color": Colors.amber[800],
      "eta": "6 min",
      "category": "Premium",
      "seats": "4",
    },
  ];

  List<Map<String, dynamic>> get _filteredOptions {
    if (_selectedCategory == "All") return _rideOptions;
    return _rideOptions
        .where((opt) => opt['category'] == _selectedCategory)
        .toList();
  }

  double _calculatePrice(double basePrice) {
    int distance = widget.distanceDuration["distance"] ?? 5;
    return basePrice * distance;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredOptions;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Handle index reset if category change makes selected index invalid
    if (_selectedIndex >= filtered.length) {
      _selectedIndex = 0;
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
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
          const SizedBox(height: 12),
          // Drag Handle
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 24),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose a ride",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.distanceDuration["duration"] ?? 15} min",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Categories Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: _categories.map((cat) {
                bool isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? Colors.blueAccent : Colors.black)
                          : (isDark ? Colors.grey[900] : Colors.grey[100]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.grey[400] : Colors.black54),
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Ride Options List
          Flexible(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: ListView.builder(
                key: ValueKey(_selectedCategory),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final option = filtered[index];
                  double price = _calculatePrice(option["basePrice"]);
                  bool isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark
                                  ? Colors.blueAccent.withValues(alpha: 0.1)
                                  : Colors.black)
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected
                              ? (isDark ? Colors.blueAccent : Colors.black)
                              : (isDark
                                    ? const Color(0xFF2C2C2C)
                                    : Colors.grey[100]!),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: isSelected && !isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : (option["color"] as Color).withValues(
                                      alpha: 0.1,
                                    ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              option["image"] as IconData,
                              color: isSelected && !isDark
                                  ? Colors.white
                                  : option["color"] as Color,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      option["name"],
                                      style: TextStyle(
                                        color: isSelected && !isDark
                                            ? Colors.white
                                            : Theme.of(
                                                context,
                                              ).textTheme.bodyLarge?.color,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.person_rounded,
                                      size: 12,
                                      color: isSelected && !isDark
                                          ? Colors.white60
                                          : Colors.black26,
                                    ),
                                    Text(
                                      " ${option['seats']}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isSelected && !isDark
                                            ? Colors.white60
                                            : Colors.black26,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  option["desc"],
                                  style: TextStyle(
                                    color: isSelected && !isDark
                                        ? Colors.white70
                                        : (isDark
                                              ? Colors.grey[400]
                                              : Colors.grey[500]),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Rs.${price.toStringAsFixed(0)}",
                                style: TextStyle(
                                  color: isSelected && !isDark
                                      ? Colors.white
                                      : Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                option["eta"],
                                style: TextStyle(
                                  color: isSelected && !isDark
                                      ? Colors.white70
                                      : (isDark
                                            ? Colors.blueAccent
                                            : Colors.green[600]),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Confirm Button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 150),
            child: GestureDetector(
              onTap: _isBooking
                  ? null
                  : () {
                      setState(() => _isBooking = true);
                      final selected = filtered[_selectedIndex];
                      final price = _calculatePrice(selected["basePrice"]);
                      widget.onRideSelected(selected["name"], price);
                    },
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isBooking ? 0.5 : 1.0,
                child: Container(
                  width: double.infinity,
                  height: 65,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.blueAccent : Colors.black,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Confirm ${filtered[_selectedIndex]["name"]}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
