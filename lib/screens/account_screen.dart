import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Elegant Header
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black87, Colors.black],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white24,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg",
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Khuzaim Sajjad",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "khuzaim.dev@example.com",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu Items
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Account Settings"),
                  _buildMenuItem(Icons.person_outline, "Personal Information"),
                  _buildMenuItem(Icons.favorite_border, "Your Favorites"),
                  _buildMenuItem(Icons.payment_outlined, "Payment Methods"),

                  const SizedBox(height: 25),
                  _buildSectionHeader("Preferences"),
                  _buildMenuItem(Icons.notifications_none, "Notifications"),
                  _buildMenuItem(Icons.language_outlined, "Language"),
                  _buildMenuItem(Icons.dark_mode_outlined, "Appearance"),

                  const SizedBox(height: 25),
                  _buildSectionHeader("Support"),
                  _buildMenuItem(Icons.help_outline, "Help Center"),
                  _buildMenuItem(Icons.policy_outlined, "Privacy Policy"),
                  _buildMenuItem(Icons.info_outline, "About Rydo"),

                  const SizedBox(height: 40),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Version 1.0.0",
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black.withValues(alpha: 0.4),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87, size: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.black26,
        ),
        onTap: () {},
      ),
    );
  }
}
