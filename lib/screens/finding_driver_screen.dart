import 'package:flutter/material.dart';

class FindingDriverScreen extends StatefulWidget {
  const FindingDriverScreen({super.key});

  @override
  State<FindingDriverScreen> createState() => _FindingDriverScreenState();
}

class _FindingDriverScreenState extends State<FindingDriverScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _buildRing(200, context),
                _buildRing(280, context),
                _buildRing(360, context),
                Icon(
                  Icons.directions_car,
                  size: 50,
                  color: isDark ? Colors.blueAccent : Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Text(
              "Finding your ride...",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Connecting you with nearby drivers",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: LinearProgressIndicator(
                backgroundColor: isDark ? Colors.grey[900] : Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark ? Colors.blueAccent : Colors.black,
                ),
                minHeight: 2,
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cancel Request",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRing(double size, BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color ringColor = isDark ? Colors.blueAccent : Colors.black;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: size * _controller.value,
          height: size * _controller.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ringColor.withValues(alpha: 1 - _controller.value),
              width: 2,
            ),
          ),
        );
      },
    );
  }
}
