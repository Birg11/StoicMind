// screens/discomfort_challenge_screen.dart
import 'package:flutter/material.dart';
import 'dart:math';

class DiscomfortChallengeScreen extends StatefulWidget {
  @override
  State<DiscomfortChallengeScreen> createState() => _DiscomfortChallengeScreenState();
}

class _DiscomfortChallengeScreenState extends State<DiscomfortChallengeScreen> {
  final List<String> challenges = [
    "Take a cold shower",
    "Spend 1 hour without your phone",
    "20-minute silent walk",
    "Sit with discomfort – 10 mins in stillness",
    "No complaining for the next 12 hours",
    "Fast for 12 hours",
    "Write down your fears and sit with them",
  ];

  late String currentChallenge;

  @override
  void initState() {
    super.initState();
    currentChallenge = _getRandomChallenge();
  }

  String _getRandomChallenge() {
    final random = Random();
    return challenges[random.nextInt(challenges.length)];
  }

  void _refreshChallenge() {
    setState(() {
      currentChallenge = _getRandomChallenge();
    });
  }

  void _logCompletion() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Challenge logged. Well done, Stoic.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Discomfort Challenge'),
        backgroundColor: isDark ? Colors.grey[900] : null,
        foregroundColor: isDark ? Colors.white : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Today’s Challenge:',
              style: theme.textTheme.titleLarge?.copyWith(
                color: isDark ? Colors.grey[100] : null,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                currentChallenge,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey[200] : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _refreshChallenge,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isDark ? Colors.grey[300] : null,
                    side: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey.shade400),
                  ),
                  child: Text('Try Another'),
                ),
                ElevatedButton(
                  onPressed: _logCompletion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.amber.shade600 : theme.primaryColor,
                  ),
                  child: Text('Log Experience'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
