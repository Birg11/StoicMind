// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stoicmind/routes.dart';
import 'package:stoicmind/widgets/daily_widget.dart';
import '../services/journal_service.dart';
import '../providers/theme_provider.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int streak = 0;
  double _opacity = 0.0;
  late final AnimationController _fadeController;

  final List<Map<String, String>> quotes = [
    {
      'quote': 'You have power over your mind — not outside events. Realize this, and you will find strength.',
      'author': 'Marcus Aurelius'
    },
    {
      'quote': 'If it is not right, do not do it; if it is not true, do not say it.',
      'author': 'Marcus Aurelius'
    },
    {
      'quote': 'It is not things that upset us, but our judgments about them.',
      'author': 'Epictetus'
    },
    {
      'quote': 'He who fears death will never do anything worthy of a man who is alive.',
      'author': 'Seneca'
    },
    {
      'quote': 'We suffer more in imagination than in reality.',
      'author': 'Seneca'
    },
  ];

  late String quote;
  late String author;

  @override
  void initState() {
    super.initState();
    streak = JournalService().calculateStreak();
    _pickRandomQuote();

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..forward();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() => _opacity = 1.0);
    });
  }

  void _pickRandomQuote() {
    final random = Random();
    final selected = quotes[random.nextInt(quotes.length)];
    quote = selected['quote']!;
    author = selected['author']!;
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      key: ValueKey<bool>(themeProvider.isDarkMode),
                    ),
                  ),
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ),
              const SizedBox(height: 12),
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '"$quote"',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[200] : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '- $author',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? Colors.grey[500] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: DailyLessonWidget(),
              ),

              const SizedBox(height: 32),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  '🔥 Day $streak of Stoic Discipline',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.morning),
                  child: Text('Start My Practice'),
                ),
              ),

              const SizedBox(height: 32),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2.4,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.library),
                    icon: Icon(Icons.menu_book),
                    label: Text('Library'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.progress),
                    icon: Icon(Icons.show_chart),
                    label: Text('Progress'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.journal),
                    icon: Icon(Icons.book),
                    label: Text('Journal'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.discomfort),
                    icon: Icon(Icons.bolt),
                    label: Text('Challenge'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
