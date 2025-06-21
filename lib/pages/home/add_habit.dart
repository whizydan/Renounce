import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _timesPerDayController = TextEditingController();
  final _hoursPerSessionController = TextEditingController();

  Future<void> _saveHabit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final habit = {
        'title': _titleController.text.trim(),
        'timesPerDay': _timesPerDayController.text.trim(),
        'hoursPerSession': _hoursPerSessionController.text.trim(),
      };

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('habit', json.encode(habit));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Habit saved successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF677E74);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: accent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Habit Title',
                  hintText: 'e.g. Meditation, Reading',
                  helperText: 'What habit are you trying to build?',
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 24),

              // Times Per Day
              TextFormField(
                controller: _timesPerDayController,
                decoration: const InputDecoration(
                  labelText: 'How Many Times Per Day?',
                  hintText: 'e.g. 2',
                  helperText: 'How many times do you want to do this habit daily?',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter frequency' : null,
              ),
              const SizedBox(height: 24),

              // Hours Per Session
              TextFormField(
                controller: _hoursPerSessionController,
                decoration: const InputDecoration(
                  labelText: 'Hours Per Session',
                  hintText: 'e.g. 1.5',
                  helperText: 'How long does each session usually take?',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter duration' : null,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _saveHabit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Habit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
