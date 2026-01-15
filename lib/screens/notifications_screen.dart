import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool promotions = false;
  bool rideUpdates = true;
  bool paymentAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader("ACTIVITY UPDATES"),
                const SizedBox(height: 16),
                _buildNotificationTile(
                  icon: Icons.directions_car_rounded,
                  iconColor: Colors.blue,
                  title: "Ride Updates",
                  subtitle: "Live tracking, driver arrival, and trip status",
                  value: rideUpdates,
                  onChanged: (val) => setState(() => rideUpdates = val),
                ),
                _buildNotificationTile(
                  icon: Icons.account_balance_wallet_rounded,
                  iconColor: Colors.green,
                  title: "Payment Alerts",
                  subtitle: "Invoices, top-ups, and refund status",
                  value: paymentAlerts,
                  onChanged: (val) => setState(() => paymentAlerts = val),
                ),
                const SizedBox(height: 32),
                _buildSectionHeader("CHANNELS"),
                const SizedBox(height: 16),
                _buildNotificationTile(
                  icon: Icons.notifications_active_rounded,
                  iconColor: Colors.orange,
                  title: "Push Notifications",
                  subtitle: "Instant phone alerts and banners",
                  value: pushNotifications,
                  onChanged: (val) => setState(() => pushNotifications = val),
                ),
                _buildNotificationTile(
                  icon: Icons.alternate_email_rounded,
                  iconColor: Colors.purple,
                  title: "Email Notifications",
                  subtitle: "Detailed trip summaries and news",
                  value: emailNotifications,
                  onChanged: (val) => setState(() => emailNotifications = val),
                ),
                _buildNotificationTile(
                  icon: Icons.sms_rounded,
                  iconColor: Colors.teal,
                  title: "SMS Notifications",
                  subtitle: "Security codes and essential alerts",
                  value: smsNotifications,
                  onChanged: (val) => setState(() => smsNotifications = val),
                ),
                const SizedBox(height: 32),
                _buildSectionHeader("MARKETING"),
                const SizedBox(height: 16),
                _buildNotificationTile(
                  icon: Icons.local_offer_rounded,
                  iconColor: Colors.redAccent,
                  title: "Promotions & Offers",
                  subtitle: "Coupons, discounts, and personalized deals",
                  value: promotions,
                  onChanged: (val) => setState(() => promotions = val),
                ),
                const SizedBox(height: 40),
                _buildFooter(),
                const SizedBox(height: 40),
              ]),
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
          "Notifications",
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
                  Icons.notifications,
                  size: 150,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildNotificationTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SwitchListTile(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.black,
          secondary: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Text(
        "Manage your notification preferences above. Some essential account security notifications cannot be disabled.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
