import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:renounce/pages/daily_log/daily.dart';
import 'package:renounce/utils/navigation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/logo');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      // Navigate to log entry page manually from here
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (_) => const DailyLogPage(),
      ));
    },
  );
}

Future<void> showDailyLogNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'daily_log_channel',
    'Daily Log Reminder',
    channelDescription: 'Reminds users to log hobby and habit counts',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Quick Check-In',
    'How many times did you do your habit & hobby today?',
    platformDetails,
  );
}
