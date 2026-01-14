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

  final List<Map<String, dynamic>> _rideOptions = [
    {
      "id": "mini",
      "name": "Rydo Mini",
      "desc": "Affordable, everyday rides",
      "basePrice": 350.0,
      "multiplier": 0.8,
      "image": Icons.directions_car_filled, // Using IconData for robustness
      "color": Colors.blue,
    },
    {
      "id": "go",
      "name": "Rydo Go",
      "desc": "Dependable rides",
      "basePrice": 550.0,
      "multiplier": 1.2,
      "image": Icons.local_taxi,
      "color": Colors.black,
    },
    {
      "id": "business",
      "name": "Business",
      "desc": "Premium rides in high-end cars",
      "basePrice": 1200.0,
      "multiplier": 2.0,
      "image": Icons.airport_shuttle,
      "color": Colors.grey[800],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 30,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 25),

          // Header
          Row(
            children: const [
              Text(
                "Choose a ride",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Ride Options List
          ...List.generate(_rideOptions.length, (index) {
            final option = _rideOptions[index];
            double price = option["basePrice"];
            bool isSelected = _selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey[50] : Colors.white,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey[200]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Vehicle Icon
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (option["color"] as Color).withValues(
                          alpha: 0.1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        option["image"] as IconData,
                        size: 28,
                        color: option["color"],
                      ),
                    ),
                    const SizedBox(width: 15),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option["name"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isSelected ? Colors.black : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            option["desc"],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs. ${price.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "3 min",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          // Book Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final selected = _rideOptions[_selectedIndex];
                widget.onRideSelected(selected["name"], selected["basePrice"]);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Confirm ${_rideOptions[_selectedIndex]["name"]}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
