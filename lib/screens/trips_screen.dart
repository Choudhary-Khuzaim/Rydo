import 'package:flutter/material.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  String selectedFilter = "All";
  final List<String> filters = ["All", "Completed", "Canceled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: _buildFilterBar(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (selectedFilter == "All" ||
                    selectedFilter == "Completed") ...[
                  _buildTripCard(
                    context,
                    date: "Today, 10:23 AM",
                    pickup: "123 Market St, Karachi",
                    dropoff: "Dolmen Mall Clifton",
                    price: "Rs. 1,250",
                    status: "Completed",
                    isCompleted: true,
                    carModel: "Toyota Camry",
                    carPlate: "ABC 123",
                  ),
                  const SizedBox(height: 20),
                ],
                if (selectedFilter == "All" ||
                    selectedFilter == "Canceled") ...[
                  _buildTripCard(
                    context,
                    date: "Yesterday, 6:45 PM",
                    pickup: "North Nazimabad, Block H",
                    dropoff: "Lucky One Mall",
                    price: "Rs. 850",
                    status: "Canceled",
                    isCompleted: false,
                    carModel: "Honda Civic",
                    carPlate: "XYZ 789",
                  ),
                  const SizedBox(height: 20),
                ],
                if (selectedFilter == "All" ||
                    selectedFilter == "Completed") ...[
                  _buildTripCard(
                    context,
                    date: "Jan 12, 2:30 PM",
                    pickup: "Jinnah International Airport",
                    dropoff: "Pearl Continental Hotel",
                    price: "Rs. 4,500",
                    status: "Completed",
                    isCompleted: true,
                    carModel: "Tesla Model 3",
                    carPlate: "ELON 1",
                  ),
                  const SizedBox(height: 40),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
        title: const Text(
          "Your Trips",
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
                right: -20,
                bottom: -20,
                child: Icon(
                  Icons.map_rounded,
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

  Widget _buildFilterBar() {
    return Row(
      children: filters.map((filter) {
        bool isSelected = selectedFilter == filter;
        return GestureDetector(
          onTap: () => setState(() => selectedFilter = filter),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.01),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey[200]!,
              ),
            ),
            child: Text(
              filter,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
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
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.circle, size: 10, color: Colors.blue),
                        Container(
                          width: 1.5,
                          height: 35,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue,
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                        const Icon(Icons.square, size: 10, color: Colors.black),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pickup,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            dropoff,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.directions_car_filled_rounded,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carModel,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          carPlate,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    _buildStatusBadge(isCompleted),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isCompleted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        isCompleted ? "COMPLETED" : "CANCELED",
        style: TextStyle(
          color: isCompleted ? Colors.green[700] : Colors.red[700],
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
