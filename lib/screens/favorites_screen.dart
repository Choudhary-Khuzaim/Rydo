import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
                _buildSearchBar(),
                const SizedBox(height: 32),
                _buildSectionHeader("SAVED PLACES"),
                const SizedBox(height: 16),
                _buildFavoriteCard(
                  context,
                  icon: Icons.home_rounded,
                  title: "Home",
                  address: "123 Market St, San Francisco",
                  distance: "1.2 km",
                  color: Colors.blue,
                ),
                _buildFavoriteCard(
                  context,
                  icon: Icons.work_rounded,
                  title: "Office",
                  address: "456 Business Ave, SF",
                  distance: "4.8 km",
                  color: Colors.indigo,
                ),
                _buildFavoriteCard(
                  context,
                  icon: Icons.fitness_center_rounded,
                  title: "Gym",
                  address: "789 Fitness Way, SF",
                  distance: "2.5 km",
                  color: Colors.orange,
                ),
                const SizedBox(height: 24),
                _buildSectionHeader("FREQUENT DESTINATIONS"),
                const SizedBox(height: 16),
                _buildFavoriteCard(
                  context,
                  icon: Icons.restaurant_rounded,
                  title: "Starbucks Coffee",
                  address: "Union Square, SF",
                  distance: "0.5 km",
                  color: Colors.green,
                ),
                _buildFavoriteCard(
                  context,
                  icon: Icons.shopping_bag_rounded,
                  title: "Central Mall",
                  address: "Down Street, SF",
                  distance: "3.1 km",
                  color: Colors.pink,
                ),
                const SizedBox(height: 40),
                _buildAddButton(),
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
        titlePadding: const EdgeInsets.only(left: 60, bottom: 20),
        title: const Text(
          "Favorites",
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
                right: -40,
                bottom: -40,
                child: Icon(
                  Icons.favorite,
                  size: 200,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search your saved places...",
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
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

  Widget _buildFavoriteCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String address,
    required String distance,
    required Color color,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(icon, color: color, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              distance,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right_rounded, color: Colors.grey[300]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add_location_alt_rounded, color: Colors.black),
        label: const Text(
          "Add New Location",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
