import 'package:flutter/material.dart';

class FindingDriverScreen extends StatefulWidget {
  const FindingDriverScreen({super.key});

  @override
  State<FindingDriverScreen> createState() => _FindingDriverScreenState();
}

class _FindingDriverScreenState extends State<FindingDriverScreen> with TickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _buildRing(200),
                _buildRing(280),
                _buildRing(360),
                const Icon(Icons.directions_car, size: 50, color: Colors.black),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              "Finding your ride...",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Connecting you with nearby drivers",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              minHeight: 2,
            ),
            const SizedBox(height: 30),
             TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel Request", style: TextStyle(color: Colors.red)),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildRing(double size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: size * _controller.value,
          height: size * _controller.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withOpacity(1 - _controller.value),
              width: 2,
            ),
          ),
        );
      },
    );
  }
}
