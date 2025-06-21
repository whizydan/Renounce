import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:renounce/utils/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class DailyLogPage extends StatefulWidget {
  const DailyLogPage({super.key});

  @override
  State<DailyLogPage> createState() => _DailyLogPageState();
}

class _DailyLogPageState extends State<DailyLogPage> {
  final habitController = TextEditingController();
  final hobbyController = TextEditingController();
  final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> saveLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final current = prefs.getString(today);
    int habit = int.tryParse(habitController.text) ?? 0;
    int hobby = int.tryParse(hobbyController.text) ?? 0;

    if (current != null && current.contains('|')) {
      final parts = current.split('|');
      habit += int.tryParse(parts[0]) ?? 0;
      hobby += int.tryParse(parts[1]) ?? 0;
    }

    // Save updated values
    await prefs.setString(today, '$habit|$hobby');

    // Optional: Schedule reminder if hobby <= habit
    if (hobby <= habit) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Remember your hobby!',
        'Try to spend more time on your hobby today.',
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 3)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Hobby Reminder',
            importance: Importance.high,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Today\'s Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: habitController,
              decoration: const InputDecoration(labelText: 'Habit Count'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: hobbyController,
              decoration: const InputDecoration(labelText: 'Hobby Count'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveLog,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
