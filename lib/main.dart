import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:stoicmind/providers/theme_provider.dart';
import 'package:stoicmind/routes.dart';
import 'package:stoicmind/screens/discomfort_challenge_screen.dart';
import 'package:stoicmind/screens/evening_reflection_screen.dart';
import 'package:stoicmind/screens/home_screen.dart';
import 'package:stoicmind/screens/journal_screen.dart';
import 'package:stoicmind/screens/library_screen.dart';
import 'package:stoicmind/screens/morning_practice_screen.dart';
import 'package:stoicmind/screens/progress_tracker_screen.dart';
import 'package:stoicmind/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stoicmind/services/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('journal');
  await Hive.openBox('settings'); // ✅ Open settings box for theme
await NotificationService.init();
await NotificationService.scheduleDailyQuote();
  tz.initializeTimeZones(); // ✅ Add this



  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: StoicMind(),
    ),
  );
}

class StoicMind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StoicMind',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFFAF9F6),
        textTheme: GoogleFonts.playfairDisplayTextTheme(
          ThemeData.light().textTheme,
        ),
        primaryColor: Color(0xFFBFA77A),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFBFA77A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColor: Color(0xFFBFA77A),
        textTheme: GoogleFonts.playfairDisplayTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => SplashScreen(),
        AppRoutes.home: (_) => HomeScreen(),
        AppRoutes.morning: (_) => MorningPracticeScreen(),
        AppRoutes.evening: (_) => EveningReflectionScreen(),
        AppRoutes.library: (_) => LibraryScreen(),
        AppRoutes.progress: (_) => ProgressTrackerScreen(),
        AppRoutes.discomfort: (_) => DiscomfortChallengeScreen(),
        AppRoutes.journal: (_) => JournalScreen(),
      },
    );
  }
}
