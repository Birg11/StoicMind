// screens/library_screen.dart
import 'package:flutter/material.dart';
import 'package:stoicmind/data/stoic_lessons.dart';
import 'package:stoicmind/screens/teachingdetail_screen.dart';


class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Stoic Library'),
        backgroundColor: isDark ? Colors.grey[900] : null,
        foregroundColor: isDark ? Colors.white : null,
        elevation: 0.5,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: stoicLessons.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = stoicLessons[index];

          return Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Text(
                item['title'],
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey[100] : null,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  item['summary'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.grey[500] : Colors.grey[600]),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TeachingDetailScreen(
                    title: item['title'],
                    quotes: List<String>.from(item['quotes']),
                    reflection: item['summary'],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
