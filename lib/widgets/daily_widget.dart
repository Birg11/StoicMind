// lib/widgets/daily_lesson_widget.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stoicmind/screens/teachingdetail_screen.dart';
import '../data/stoic_lessons.dart';

class DailyLessonWidget extends StatelessWidget {
  const DailyLessonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final random = Random();
    final daily = stoicLessons[random.nextInt(stoicLessons.length)];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TeachingDetailScreen(
            title: daily['title'],
            quotes: List<String>.from(daily['quotes']),
            reflection: daily['summary'],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Color(0xFFFDFDFD),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🧠 Stoic of the Day',
              style: theme.textTheme.labelLarge?.copyWith(
                color: isDark ? Colors.grey[300] : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              daily['title'],
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              daily['summary'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
