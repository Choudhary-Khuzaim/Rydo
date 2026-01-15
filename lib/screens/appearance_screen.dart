import 'package:flutter/material.dart';
import 'package:rydo/theme/theme_manager.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late String selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = ThemeManager.getThemeName();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionLabel("THEME MODE"),
                const SizedBox(height: 20),
                _buildThemeCard(
                  title: "Light Mode",
                  subtitle: "Standard and crisp white interface",
                  icon: Icons.light_mode_rounded,
                  color: Colors.orange,
                  previewColors: [Colors.white, Colors.grey[100]!, Colors.blue],
                ),
                _buildThemeCard(
                  title: "Dark Mode",
                  subtitle: "Easier on eyes and saves battery",
                  icon: Icons.dark_mode_rounded,
                  color: Colors.indigo,
                  previewColors: [
                    Colors.black,
                    const Color(0xFF1A1A1A),
                    Colors.blue,
                  ],
                ),
                _buildThemeCard(
                  title: "System Default",
                  subtitle: "Sync with your device settings",
                  icon: Icons.settings_suggest_rounded,
                  color: Colors.teal,
                  previewColors: [Colors.white, Colors.black, Colors.blue],
                ),
                const SizedBox(height: 32),
                _buildConfirmButton(),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      elevation: 0,
      backgroundColor: isDark ? Colors.blueAccent : Colors.black,
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
          "Appearance",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1A1A1A), Colors.blueAccent]
                  : [Colors.black, const Color(0xFF2D2D2D)],
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
                  Icons.palette_rounded,
                  size: 150,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: Colors.grey[500],
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildThemeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<Color> previewColors,
  }) {
    bool isSelected = selectedTheme == title;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => selectedTheme = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? (isDark ? Colors.blueAccent : Colors.black)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.black.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.02),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _buildThemePreview(previewColors),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview(List<Color> colors) {
    return SizedBox(
      width: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: colors[0],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[400]!, width: 1),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: colors[1],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[400]!, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          ThemeManager.setTheme(selectedTheme);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Appearance updated to $selectedTheme"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: isDark ? Colors.blueAccent : Colors.black,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.blueAccent : Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "Save Appearance",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
