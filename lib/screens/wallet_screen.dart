import 'package:flutter/material.dart';
import 'package:rydo/screens/top_up_screen.dart';
import 'package:rydo/screens/send_money_screen.dart';
import 'package:rydo/screens/activity_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "My Wallet",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Balance Card
            _buildBalanceCard(),
            const SizedBox(height: 30),

            // Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAction(Icons.add_rounded, "Top Up", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TopUpScreen(),
                    ),
                  );
                }),
                _buildQuickAction(Icons.send_rounded, "Send", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SendMoneyScreen(),
                    ),
                  );
                }),
                _buildQuickAction(Icons.history_rounded, "Activity", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActivityScreen(),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 40),

            // Transactions Header
            const Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Transactions List
            _buildTransactionItem(
              "Ride to Airport",
              "14 Jan, 08:30 PM",
              "Rs. 4,500",
              false,
            ),
            _buildTransactionItem(
              "Wallet Topup",
              "12 Jan, 11:15 AM",
              "Rs. 10,000",
              true,
            ),
            _buildTransactionItem(
              "Night Ride Home",
              "10 Jan, 11:45 PM",
              "Rs. 1,250",
              false,
            ),
            _buildTransactionItem(
              "Refund - Cancelled Trip",
              "08 Jan, 02:20 PM",
              "Rs. 500",
              true,
            ),

            const SizedBox(height: 100), // Space for floating nav
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Balance",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png",
                height: 30,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Rs. 12,250",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "**** **** **** 4582",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black, size: 28),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
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
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: isPositive
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isPositive ? Icons.north_east_rounded : Icons.south_west_rounded,
              color: isPositive ? Colors.green[700] : Colors.red[700],
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
                  date,
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
