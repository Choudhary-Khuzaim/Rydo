import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Transaction Activity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDayHeader("Today"),
          _buildTransactionItem(
            "Ride to Airport",
            "08:30 PM",
            "Rs. 4,500",
            false,
          ),
          _buildTransactionItem("Lunch at McD", "01:15 PM", "Rs. 1,520", false),

          const SizedBox(height: 20),
          _buildDayHeader("Yesterday"),
          _buildTransactionItem("Wallet Topup", "11:15 AM", "Rs. 10,000", true),
          _buildTransactionItem("Sent to Alex", "09:45 AM", "Rs. 2,000", false),

          const SizedBox(height: 20),
          _buildDayHeader("12 Jan 2026"),
          _buildTransactionItem(
            "Night Ride Home",
            "11:45 PM",
            "Rs. 1,250",
            false,
          ),
          _buildTransactionItem(
            "Refund - Trip #124",
            "02:20 PM",
            "Rs. 500",
            true,
          ),
          _buildTransactionItem(
            "Grocery Store",
            "10:30 AM",
            "Rs. 3,400",
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black38,
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String time,
    String amount,
    bool isPositive,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: isPositive
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isPositive ? Icons.north_east_rounded : Icons.south_west_rounded,
              color: isPositive ? Colors.green[700] : Colors.red[700],
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.black38, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isPositive ? Colors.green[700] : Colors.red[700],
            ),
          ),
        ],
      ),
    );
  }
}
