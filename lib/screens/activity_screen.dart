import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildDayHeader("Today"),
                _buildTransactionItem(
                  icon: Icons.flight_takeoff_rounded,
                  title: "Ride to Airport",
                  subtitle: "Trip #45821 • 08:30 PM",
                  amount: "4,500",
                  isPositive: false,
                  category: "Ride",
                ),
                _buildTransactionItem(
                  icon: Icons.fastfood_rounded,
                  title: "Lunch at McD",
                  subtitle: "Payment • 01:15 PM",
                  amount: "1,520",
                  isPositive: false,
                  category: "Food",
                ),
                const SizedBox(height: 24),
                _buildDayHeader("Yesterday"),
                _buildTransactionItem(
                  icon: Icons.account_balance_wallet_rounded,
                  title: "Wallet Topup",
                  subtitle: "Mastercard • 11:15 AM",
                  amount: "10,000",
                  isPositive: true,
                  category: "Wallet",
                ),
                _buildTransactionItem(
                  icon: Icons.person_add_rounded,
                  title: "Sent to Alex",
                  subtitle: "Transfer • 09:45 AM",
                  amount: "2,000",
                  isPositive: false,
                  category: "Transfer",
                ),
                const SizedBox(height: 24),
                _buildDayHeader("12 Jan 2026"),
                _buildTransactionItem(
                  icon: Icons.directions_car_rounded,
                  title: "Night Ride Home",
                  subtitle: "Trip #45790 • 11:45 PM",
                  amount: "1,250",
                  isPositive: false,
                  category: "Ride",
                ),
                _buildTransactionItem(
                  icon: Icons.history_rounded,
                  title: "Refund - Trip #124",
                  subtitle: "Adjustment • 02:20 PM",
                  amount: "500",
                  isPositive: true,
                  category: "Refund",
                ),
                const SizedBox(height: 20),
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
        titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
        title: const Text(
          "Activity",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        background: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFF333333)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -20,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Colors.grey[500],
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required bool isPositive,
    required String category,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.black, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isPositive ? '+' : '-'} Rs. $amount",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: isPositive ? Colors.green[700] : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
