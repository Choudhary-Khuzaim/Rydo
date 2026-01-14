import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Slightly off-white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Your Trips",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          _buildTripCard(
            context,
            date: "Today, 10:23 AM",
            pickup: "123 Market St",
            dropoff: "Union Square, SF",
            price: "Rs. 1,250",
            status: "Completed",
            isCompleted: true,
            carModel: "Toyota Camry",
            carPlate: "ABC 123",
          ),
          const SizedBox(height: 15),
          _buildTripCard(
            context,
            date: "Yesterday, 6:45 PM",
            pickup: "Office",
            dropoff: "Home",
            price: "Rs. 850",
            status: "Canceled",
            isCompleted: false,
            carModel: "Honda Civic",
            carPlate: "XYZ 789",
          ),
          const SizedBox(height: 15),
          _buildTripCard(
            context,
            date: "Jan 12, 2:30 PM",
            pickup: "Hotel California",
            dropoff: "San Francisco Int. Airport",
            price: "Rs. 4,500",
            status: "Completed",
            isCompleted: true,
            carModel: "Tesla Model 3",
            carPlate: "ELON 1",
          ),
        ],
      ),
    );
  }

  Widget _buildTripCard(
    BuildContext context, {
    required String date,
    required String pickup,
    required String dropoff,
    required String price,
    required String status,
    required bool isCompleted,
    required String carModel,
    required String carPlate,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header: Date & Price
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5),
          // Body: Route & Car Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.directions_car,
                    color: Colors.blue[700],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                // Route Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pickup
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 8, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            pickup,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 3.5),
                        height: 16,
                        width: 1,
                        color: Colors.grey[300],
                      ),
                      // Dropoff
                      Row(
                        children: [
                          const Icon(
                            Icons.square,
                            size: 8,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dropoff,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Car Info
                      Row(
                        children: [
                          Text(
                            carModel,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.circle, size: 4, color: Colors.grey[400]),
                          const SizedBox(width: 8),
                          Text(
                            carPlate,
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
              ],
            ),
          ),
          // Footer: Status
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withValues(alpha: 0.05)
                  : Colors.red.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                isCompleted ? "TRIP COMPLETED" : "TRIP CANCELED",
                style: TextStyle(
                  color: isCompleted ? Colors.green[700] : Colors.red[700],
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
