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
      "basePrice": 5.0,
      "multiplier": 0.8,
      "image": "https://raw.githubusercontent.com/googlemaps-samples/codelab-maps-platform-101-flutter/master/assets/images/uber_go.png", // placeholder
    },
    {
      "id": "go",
      "name": "Rydo Go",
      "desc": "Dependable rides",
      "basePrice": 8.0,
      "multiplier": 1.2,
      "image": "https://raw.githubusercontent.com/googlemaps-samples/codelab-maps-platform-101-flutter/master/assets/images/uber_x.png", // placeholder
    },
    {
      "id": "business",
      "name": "Business",
      "desc": "Premium rides in high-end cars",
      "basePrice": 15.0,
      "multiplier": 2.0,
      "image": "https://raw.githubusercontent.com/googlemaps-samples/codelab-maps-platform-101-flutter/master/assets/images/uber_black.png", // placeholder
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Choose a ride",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(_rideOptions.length, (index) {
             final option = _rideOptions[index];
             // Simple price calc: Base + (Dist * Multiplier) (Mock distance 5km for now if not passed)
             double price = option["basePrice"]; // simplistic
             
             return GestureDetector(
               onTap: () {
                 setState(() => _selectedIndex = index);
               },
               child: Container(
                 margin: const EdgeInsets.only(bottom: 10),
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(
                   color: _selectedIndex == index ? Colors.black.withOpacity(0.05) : Colors.white,
                   border: Border.all(
                     color: _selectedIndex == index ? Colors.black : Colors.transparent,
                     width: 2,
                   ),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Row(
                   children: [
                     Image.network(
                       option["image"],
                       width: 60,
                       errorBuilder: (_,__,___) => const Icon(Icons.directions_car, size: 40),
                     ),
                     const SizedBox(width: 15),
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             option["name"],
                             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                           ),
                           Text(
                             option["desc"],
                             style: TextStyle(color: Colors.grey[600], fontSize: 12),
                           ),
                         ],
                       ),
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Text(
                           "\$${price.toStringAsFixed(2)}",
                           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                         ),
                         const Text(
                           "3 min",
                           style: TextStyle(color: Colors.grey, fontSize: 12),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
             );
          }),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final selected = _rideOptions[_selectedIndex];
                widget.onRideSelected(selected["name"], selected["basePrice"]);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                "Confirm ${_rideOptions[_selectedIndex]["name"]}",
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
