// screens/journal_screen.dart
import 'package:flutter/material.dart';
import '../services/journal_service.dart';

class JournalScreen extends StatefulWidget {
  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<Map<String, dynamic>> journalEntries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    final entries = JournalService().getEntries();
    setState(() {
      journalEntries = entries.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Stoic Journal'),
        backgroundColor: isDark ? Colors.grey[900] : null,
        foregroundColor: isDark ? Colors.white : null,
        elevation: 0.5,
      ),
      body: journalEntries.isEmpty
          ? Center(
              child: Text(
                'No entries yet.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.black87,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(24.0),
              itemCount: journalEntries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final entry = journalEntries[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry['date'] ?? '',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry['entry'] ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? Colors.grey[100] : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
