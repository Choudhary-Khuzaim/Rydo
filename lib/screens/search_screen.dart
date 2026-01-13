import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  // Mock data for suggestions since we might not have a valid API key for Places yet
  final List<String> _mockLocations = [
    "Uber HQ, San Francisco",
    "Golden Gate Bridge, San Francisco",
    "Pier 39, San Francisco",
    "Alcatraz Island, San Francisco",
    "Union Square, San Francisco",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Plan your ride"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildLocationField(
                  controller: _pickupController,
                  icon: Icons.my_location,
                  hint: "Current Location",
                  isPickup: true,
                ),
                const SizedBox(height: 10),
                _buildLocationField(
                  controller: _dropoffController,
                  icon: Icons.location_on,
                  hint: "Where to?",
                  isPickup: false,
                  autoFocus: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _mockLocations.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(_mockLocations[index]),
                  onTap: () {
                    // Return the selected location
                    Navigator.pop(context, _mockLocations[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required bool isPickup,
    bool autoFocus = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: isPickup ? Colors.blue : Colors.red),
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
