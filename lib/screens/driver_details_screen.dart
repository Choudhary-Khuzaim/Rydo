import 'package:flutter/material.dart';

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({super.key});

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  String _status = "Arriving in 4 minutes";
  double _progress = 0.7;
  int _state = 0; // 0: Arriving, 1: Arrived, 2: In Progress, 3: Completed

  void _advanceState() {
    setState(() {
      _state++;
      if (_state == 1) {
        _status = "Driver has arrived";
        _progress = 1.0;
      } else if (_state == 2) {
        _status = "Heading to destination";
        _progress = 0.2; // Reset for trip
      } else if (_state == 3) {
        _status = "Trip Completed";
        _progress = 1.0;
        // Show payment summary or just pop after delay
        Future.delayed(const Duration(seconds: 2), () {
           if(mounted) Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("En Route"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(), // Hide back button for now
        actions: [
          TextButton(
            onPressed: () {
               // Simulate cancel
               Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          )
        ],
      ),
      body: Column(
        children: [
          // Map placeholder (in real app, this would be a live map)
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[300],
              child: Stack(
                children: [
                   const Center(child: Text("Live Tracking Map Placeholder")),
                   Positioned(
                     bottom: 20,
                     right: 20,
                     child: FloatingActionButton.extended(
                       onPressed: _state < 3 ? _advanceState : null,
                       label: Text(_state == 0 ? "Sim: Arrive" : _state == 1 ? "Sim: Start Trip" : "Sim: End Trip"),
                       icon: const Icon(Icons.developer_mode),
                       backgroundColor: Colors.black,
                     ),
                   )
                ],
              ),
            ),
          ),
          // Driver Details Panel
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/32.jpg"),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Michael D.",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              SizedBox(width: 4),
                              Text("4.9", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(" (2.5k trips)", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "Toyota Camry",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                         Text(
                          "ABC 1234",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(Icons.message, "Message", Colors.blue),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildActionButton(Icons.call, "Call", Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                 const Divider(),
                 const SizedBox(height: 10),
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Text(
                     _status,
                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                   ),
                 ),
                 const SizedBox(height: 5),
                 LinearProgressIndicator(
                   value: _progress,
                   backgroundColor: Colors.grey[200],
                   valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
