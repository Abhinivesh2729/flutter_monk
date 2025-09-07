import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_monk/features/create_app/create_app.dart';
import 'package:flutter_monk/widgets/bg_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _motivationalQuotes = [
    "People have dreams",
    "love the code marry a developer",
    "Stay strong, code well",
    "Good employee becomes a good employer",
    "Code is poetry in motion",
    "Debug your life, not just your code",
    "Think twice, code once",
    "Every bug is a learning opportunity",
    "Code with passion, debug with patience",
    "The best code is no code at all",
    "Simplicity is the ultimate sophistication",
    "Code never lies, comments sometimes do",
  ];

  String _getRandomQuote() {
    final random = Random();
    return _motivationalQuotes[random.nextInt(_motivationalQuotes.length)];
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return DateFormat('HH: mm').format(now);
  }

  String _getCurrentDay() {
    final now = DateTime.now();
    return DateFormat('EEEE').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgContainer(
        child: Stack(
          children: [
            // Main content - Quote and Time (centered, slightly above center)
            Center(
              child: Transform.translate(
                offset: const Offset(0, -150), // Move slightly above center
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Motivational Quote
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        _getRandomQuote(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Time
                    Text(
                      _getCurrentTime(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 68,
                        fontWeight: FontWeight.w200,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Day
                    Text(
                      _getCurrentDay(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Create App Button (bottom right)
            // Create App Button (below day text)
            Center(
              child: Transform.translate(
                offset: const Offset(0, 200), // Position below the day text
                child: FloatingActionButton.extended(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAppScreen(),
                    ),
                  ),
                  backgroundColor: Colors.white.withOpacity(0.1),
                  foregroundColor: Colors.white,
                  label: const Text(
                    "Create App",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
