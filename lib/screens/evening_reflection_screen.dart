// screens/evening_reflection_screen.dart
import 'package:flutter/material.dart';
import '../services/journal_service.dart';

class EveningReflectionScreen extends StatefulWidget {
  @override
  State<EveningReflectionScreen> createState() => _EveningReflectionScreenState();
}

class _EveningReflectionScreenState extends State<EveningReflectionScreen> {
  final TextEditingController _controller = TextEditingController();
  int rating = 0;

  void _saveReflection() {
    final text = _controller.text.trim();
    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please rate your day.')),
      );
      return;
    }
    if (text.isNotEmpty) {
      final now = DateTime.now();
      final formattedDate = '${now.month}/${now.day}/${now.year}';
      JournalService().addEntry(formattedDate, text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reflection saved.')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please write your reflection.')),
      );
    }
  }

  Widget _buildStar(int index) {
    return IconButton(
      icon: Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: Color(0xFFBFA77A),
        size: 32,
      ),
      onPressed: () => setState(() => rating = index + 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Evening Reflection')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How was your day?',
              style: theme.textTheme.titleLarge,
            ),
            Row(
              children: List.generate(5, (index) => _buildStar(index)),
            ),
            const SizedBox(height: 24),
            Text(
              'Did I act with virtue today?',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Write your thoughts here...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Awareness is the beginning of change.',
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveReflection,
                child: Text('Save Reflection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
