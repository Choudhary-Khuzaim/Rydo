import 'package:flutter/material.dart';
import 'package:rydo/screens/top_up_screen.dart';
import 'package:rydo/screens/send_money_screen.dart';
import 'package:rydo/screens/activity_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBalanceCard(),
                  const SizedBox(height: 40),
                  _buildSectionHeader("QUICK ACTIONS"),
                  const SizedBox(height: 20),
                  _buildQuickActions(context),
                  const SizedBox(height: 48),
                  _buildSectionHeader("RECENT TRANSACTIONS"),
                  const SizedBox(height: 24),
                  _buildTransactionList(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
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
        titlePadding: const EdgeInsets.only(left: 60, bottom: 20),
        title: const Text(
          "My Wallet",
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
                right: -30,
                bottom: -30,
                child: Icon(
                  Icons.account_balance_wallet_rounded,
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

  Widget _buildBalanceCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: const LinearGradient(
              colors: [Color(0xFF111111), Color(0xFF2D2D2D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Balance",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Rs. 12,250.00",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "**** **** **** 4582",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png",
                    height: 25,
                    color: Colors.white.withOpacity(0.8),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: Colors.grey[500],
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(
          Icons.add_rounded,
          "Top Up",
          Colors.blue,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TopUpScreen()),
          ),
        ),
        _buildActionItem(
          Icons.send_rounded,
          "Send",
          Colors.orange,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SendMoneyScreen()),
          ),
        ),
        _buildActionItem(
          Icons.history_rounded,
          "Activity",
          Colors.teal,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActivityScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black, size: 30),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: [
        _buildTransactionItem(
          "Ride to Airport",
          "14 Jan 2026, 08:30 PM",
          "- Rs. 4,500",
          false,
          Icons.directions_car_filled_rounded,
        ),
        _buildTransactionItem(
          "Wallet Topup",
          "12 Jan 2026, 11:15 AM",
          "+ Rs. 10,000",
          true,
          Icons.account_balance_wallet_rounded,
        ),
        _buildTransactionItem(
          "Night Ride Home",
          "10 Jan 2026, 11:45 PM",
          "- Rs. 1,250",
          false,
          Icons.directions_car_filled_rounded,
        ),
        _buildTransactionItem(
          "Refund - Cancelled Trip",
          "08 Jan 2026, 02:20 PM",
          "+ Rs. 500",
          true,
          Icons.refresh_rounded,
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
    String amount,
    bool isPositive,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.black, size: 24),
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
                    fontSize: 15,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: isPositive ? Colors.green[600] : Colors.red[400],
            ),
          ),
        ],
      ),
    );
  }
}
