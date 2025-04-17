// lib/services/notification_service.dart
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static final List<String> motivationalQuotes = [
    'You have power over your mind — not outside events.',
    'It is not things that upset us, but our judgments about them.',
    'We suffer more in imagination than in reality.',
    'He who fears death will never do anything worthy of a man who is alive.',
    'If it is not right, do not do it; if it is not true, do not say it.',
    'Waste no more time arguing what a good man should be. Be one.',
  ];

  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> scheduleDailyQuote() async {
    final random = Random();
    final quote = motivationalQuotes[random.nextInt(motivationalQuotes.length)];

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'daily_quote_channel',
      'Daily Motivational Quotes',
      channelDescription: 'Delivers a Stoic quote every morning',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, 8);
    final next8AM = scheduledTime.isBefore(now) ? scheduledTime.add(Duration(days: 1)) : scheduledTime;

    await _notificationsPlugin.zonedSchedule(
      0,
      'Daily Stoic Reminder',
      quote,
      next8AM,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}