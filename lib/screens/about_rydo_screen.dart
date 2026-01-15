import 'package:flutter/material.dart';

class AboutRydoScreen extends StatelessWidget {
  const AboutRydoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildBranding(context),
                const SizedBox(height: 48),
                _buildSectionHeader("OUR VALUES"),
                const SizedBox(height: 16),
                _buildValueCard(
                  Icons.auto_awesome_rounded,
                  "Innovative Travel",
                  "Redefining urban mobility with smart, predictive tech.",
                  Colors.blue,
                ),
                _buildValueCard(
                  Icons.security_rounded,
                  "Safety First",
                  "Every trip is monitored and protected by 24/7 support.",
                  Colors.green,
                ),
                _buildValueCard(
                  Icons.eco_rounded,
                  "Eco-Friendly",
                  "Committed to a sustainable and greener future for all.",
                  Colors.teal,
                ),
                const SizedBox(height: 32),
                _buildSectionHeader("CONNECT WITH US"),
                const SizedBox(height: 16),
                _buildSocialLinks(),
                const SizedBox(height: 48),
                _buildLegalLinks(),
                const SizedBox(height: 60),
                const Text(
                  "© 2026 Rydo Global Inc.",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Made with ♥ by Team Rydo",
                  style: TextStyle(color: Colors.black12, fontSize: 10),
                ),
                const SizedBox(height: 40),
              ],
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
          "About Rydo",
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
                  Icons.info_outline_rounded,
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

  Widget _buildBranding(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Icon(
            Icons.directions_car_filled_rounded,
            color: Colors.white,
            size: 55,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "RYDO",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "Version 1.0.0",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Colors.black45,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            "Rydo is a modern ride-sharing and financial ecosystem designed for the next generation of urban travelers.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildValueCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
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
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.facebook_rounded, "Facebook"),
        _buildSocialIcon(Icons.camera_alt_rounded, "Instagram"),
        _buildSocialIcon(Icons.alternate_email_rounded, "Twitter"),
        _buildSocialIcon(Icons.language_rounded, "Website"),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black87, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLinks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTextLink("Terms of Use"),
          _buildTextLink("Safety Guidelines"),
          _buildTextLink("Contact"),
        ],
      ),
    );
  }

  Widget _buildTextLink(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
