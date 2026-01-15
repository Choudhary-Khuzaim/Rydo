import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "English (US)";
  String searchQuery = "";

  final List<Map<String, String>> suggestedLanguages = [
    {"name": "English (US)", "flag": "🇺🇸", "native": "English"},
    {"name": "Urdu (Pakistan)", "flag": "🇵🇰", "native": "اردو"},
  ];

  final List<Map<String, String>> allLanguages = [
    {"name": "Arabic (UAE)", "flag": "🇦🇪", "native": "العربية"},
    {"name": "French (France)", "flag": "🇫🇷", "native": "Français"},
    {"name": "German (Germany)", "flag": "🇩🇪", "native": "Deutsch"},
    {"name": "Spanish (Spain)", "flag": "🇪🇸", "native": "Español"},
    {"name": "Chinese (China)", "flag": "🇨🇳", "native": "中文"},
    {"name": "Japanese (Japan)", "flag": "🇯🇵", "native": "日本語"},
    {"name": "Portuguese (Brazil)", "flag": "🇧🇷", "native": "Português"},
    {"name": "Russian (Russia)", "flag": "🇷🇺", "native": "Русский"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredLanguages = allLanguages
        .where(
          (lang) =>
              lang['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              lang['native']!.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

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
                if (searchQuery.isEmpty) ...[
                  const SizedBox(height: 32),
                  _buildSectionHeader("SUGGESTED LANGUAGES"),
                  const SizedBox(height: 16),
                  ...suggestedLanguages.map((lang) => _buildLanguageCard(lang)),
                ],
                const SizedBox(height: 32),
                _buildSectionHeader(
                  searchQuery.isEmpty ? "ALL LANGUAGES" : "SEARCH RESULTS",
                ),
                const SizedBox(height: 16),
                ...filteredLanguages.map((lang) => _buildLanguageCard(lang)),
                const SizedBox(height: 40),
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
          "Language",
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
                  Icons.translate_rounded,
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
        onChanged: (value) => setState(() => searchQuery = value),
        decoration: InputDecoration(
          hintText: "Search language...",
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

  Widget _buildLanguageCard(Map<String, String> lang) {
    bool isSelected = selectedLanguage == lang["name"];
    return GestureDetector(
      onTap: () => setState(() => selectedLanguage = lang["name"]!),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.black.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.01),
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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(lang["flag"]!, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang["name"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected ? Colors.black : Colors.black87,
                    ),
                  ),
                  Text(
                    lang["native"]!,
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Colors.black)
            else
              Icon(Icons.circle_outlined, color: Colors.grey[200]),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "Apply Changes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
