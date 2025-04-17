// lib/services/journal_service.dart
import 'package:hive/hive.dart';

class JournalService {
  final Box _box = Hive.box('journal');

  List<Map<String, dynamic>> getEntries() {
    return _box.values
        .where((e) => e is Map && e.containsKey('date') && e.containsKey('entry'))
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  void addEntry(String date, String text) {
    _box.add({'date': date, 'entry': text});
  }

  void clearAll() {
    _box.clear();
  }

  /// 🔥 Returns how many consecutive days have journal entries
  int calculateStreak() {
    final entries = getEntries();
    if (entries.isEmpty) return 0;

    final today = DateTime.now();
    int streak = 0;

    for (int i = 0; i < 30; i++) {
      final checkDate = DateTime(today.year, today.month, today.day - i);
      final formatted = '${checkDate.month}/${checkDate.day}/${checkDate.year}';
      final exists = entries.any((e) => e['date'] == formatted);
      if (exists) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }
}
