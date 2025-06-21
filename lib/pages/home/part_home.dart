import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renounce/utils/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_habit.dart';
import 'add_hobby.dart';

class PartHome extends StatefulWidget {
  const PartHome({super.key});

  @override
  State<PartHome> createState() => _PartHomeState();
}

class _PartHomeState extends State<PartHome> {
  @override
  void initState() {
    super.initState();
    _checkUserPrefs();
    showDailyLogNotification();
  }

  Future<void> _checkUserPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final habit = prefs.getString('habit');
    final hobby = prefs.getString('hobby');

    if (habit == null || habit.trim().isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AddHabit()),
      );
    } else if (hobby == null || hobby.trim().isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AddHobby()),
      );
    }
  }

  Widget _buildTodayCard(String? data) {
  int habit = 0, hobby = 0;
  if (data != null && data.contains('|')) {
    final parts = data.split('|');
    habit = int.tryParse(parts[0]) ?? 0;
    hobby = int.tryParse(parts[1]) ?? 0;
  }

  final advice = hobby > habit
      ? 'Great job! You’re enjoying your hobby well.'
      : 'Try to give your hobby a little more time today.';

  return Card(
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Today\'s Progress', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text('Habit: $habit times • Hobby: $hobby times'),
          const SizedBox(height: 10),
          Text(advice, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}

Widget _buildHistoryList(Map<String, String> allData) {
  final entries = allData.entries.toList()
    ..sort((a, b) => b.key.compareTo(a.key)); // latest first

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: entries.length,
    itemBuilder: (context, index) {
      final key = entries[index].key;
      final value = entries[index].value;
      final parts = value.split('|');
      final habit = parts[0];
      final hobby = parts[1];
      return ListTile(
        title: Text(key),
        subtitle: Text('Habit: $habit • Hobby: $hobby'),
        leading: const Icon(Icons.calendar_today),
      );
    },
  );
}

  @override
Widget build(BuildContext context) {
  return FutureBuilder(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const CircularProgressIndicator();
      final prefs = snapshot.data!;
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final todayData = prefs.getString(today);

      final allData = prefs.getKeys().where((k) => k.contains('-')).fold<Map<String, String>>({}, (map, key) {
        final val = prefs.getString(key);
        if (val != null) map[key] = val;
        return map;
      });

      return Scaffold(
        appBar: AppBar(title: const Text('Participation Tracker')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTodayCard(todayData),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Past Days', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              _buildHistoryList(allData),
            ],
          ),
        ),
      );
    },
  );
}
}
