// screens/progress_tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/journal_service.dart';

class ProgressTrackerScreen extends StatefulWidget {
  @override
  State<ProgressTrackerScreen> createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  final List<String> virtues = ["Courage", "Discipline", "Patience", "Justice", "Wisdom"];
  final List<double> scores = [4, 3, 5, 2.5, 4];
  late Set<String> entryDates;

  @override
  void initState() {
    super.initState();
    entryDates = JournalService().getEntries().map((e) => e['date'] as String).toSet();
  }

  bool _isJournaledDay(DateTime day) {
    final formatted = '${day.month}/${day.day}/${day.year}';
    return entryDates.contains(formatted);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final streak = JournalService().calculateStreak();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Progress Tracker'),
        backgroundColor: isDark ? Colors.grey[900] : null,
        foregroundColor: isDark ? Colors.white : null,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '🔥 Current Streak: $streak day${streak == 1 ? '' : 's'}',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: isDark ? Colors.white : null,
                ),
              ),
              const SizedBox(height: 16),
              TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: DateTime.now(),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color(0xFFBFA77A),
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: isDark ? Colors.amber : Colors.black87,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (_isJournaledDay(date)) {
                      return Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.amber : Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                calendarFormat: CalendarFormat.month,
              ),
              const SizedBox(height: 24),
              Text(
                '🧭 Virtue Radar',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey[100] : null,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                height: 300,
                child: RadarChart(
                  RadarChartData(
                    dataSets: [
                      RadarDataSet(
                        dataEntries: scores.map((v) => RadarEntry(value: v)).toList(),
                        fillColor: Color(0xFFBFA77A).withOpacity(0.4),
                        borderColor: Color(0xFFBFA77A),
                        entryRadius: 3,
                        borderWidth: 2,
                      )
                    ],
                    radarBackgroundColor: Colors.transparent,
                    radarShape: RadarShape.polygon,
                    titleTextStyle: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.grey[300] : Colors.black,
                    ),
                    getTitle: (index, angle) => RadarChartTitle(
                      text: virtues[index],
                      angle: angle,
                    ),
                    tickCount: 5,
                    ticksTextStyle: TextStyle(
                      color: isDark ? Colors.grey[600] : Colors.grey,
                      fontSize: 10,
                    ),
                    gridBorderData: BorderSide(
                      color: isDark ? Colors.grey[700]! : Colors.grey.shade300,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
