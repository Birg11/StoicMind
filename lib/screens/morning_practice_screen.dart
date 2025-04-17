// screens/morning_practice_screen.dart
import 'package:flutter/material.dart';
import '../services/journal_service.dart';

class MorningPracticeScreen extends StatefulWidget {
  @override
  State<MorningPracticeScreen> createState() => _MorningPracticeScreenState();
}

class _MorningPracticeScreenState extends State<MorningPracticeScreen> {
  final TextEditingController _controller = TextEditingController();
  String encouragement = "You begin the day with reason.";

  void _saveEntry() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final now = DateTime.now();
      final formattedDate = '${now.month}/${now.day}/${now.year}';
      JournalService().addEntry(formattedDate, text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reflection saved.')),
      );
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please write something.')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Morning Practice'),
        backgroundColor: isDark ? Colors.grey[900] : null,
        foregroundColor: isDark ? Colors.white : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What can I control today?',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Write your thoughts here...',
                filled: true,
                fillColor: isDark ? Colors.grey[850] : Colors.white,
                hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              encouragement,
              style: theme.textTheme.titleMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.amber.shade600 : theme.primaryColor,
                ),
                child: Text('Mark as Done'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
