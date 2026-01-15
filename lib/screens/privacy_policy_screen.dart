import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                  _buildHeaderSection(),
                  const SizedBox(height: 32),
                  _buildPolicyCard(
                    "1. Information Collection",
                    "We collect information that you provide directly to us, such as when you create or modify your account, request services, contact customer support, or otherwise communicate with us. This includes your name, email, phone number, and payment details.",
                    Icons.data_usage_rounded,
                  ),
                  _buildPolicyCard(
                    "2. How We Use Data",
                    "The data we collect is primarily used to provide, maintain, and improve our services. This includes facilitating payments, sending trip receipts, optimizing routes, and ensuring a safe environment for both riders and drivers.",
                    Icons.security_rounded,
                  ),
                  _buildPolicyCard(
                    "3. Data Sharing",
                    "We do not sell your personal data. We may share your information with third-party service providers who perform services on our behalf, such as payment processing and data analysis, or when required by law.",
                    Icons.share_rounded,
                  ),
                  _buildPolicyCard(
                    "4. Data Security",
                    "We implement industry-standard security measures to protect your information. This includes encryption for payment data and secure authentication protocols for account access.",
                    Icons.lock_outline_rounded,
                  ),
                  _buildPolicyCard(
                    "5. Your Rights",
                    "You have the right to access, correct, or delete your personal information at any time through the account settings. You can also opt-out of optional data collection for marketing purposes.",
                    Icons.person_pin_rounded,
                  ),
                  const SizedBox(height: 40),
                  _buildFooterSection(),
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
          "Privacy Policy",
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
                  Icons.policy_rounded,
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

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "Version 1.0.0",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Legal & Privacy",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Last updated on Jan 15, 2026",
          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildPolicyCard(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.black87, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection() {
    return Center(
      child: Column(
        children: [
          Text(
            "Questions about our policy?",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Contact Privacy Team",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
