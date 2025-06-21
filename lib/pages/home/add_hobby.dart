import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHobby extends StatefulWidget {
  const AddHobby({super.key});

  @override
  State<AddHobby> createState() => _AddHobbyState();
}

class _AddHobbyState extends State<AddHobby> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<Map<String, dynamic>> _hobbies = [];

  @override
  void initState() {
    super.initState();
    _loadHobbies();
  }

  Future<void> _loadHobbies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hobbiesJson = prefs.getString('hobby');
    if (hobbiesJson != null && hobbiesJson.isNotEmpty) {
      setState(() {
        _hobbies = List<Map<String, dynamic>>.from(json.decode(hobbiesJson));
      });
    }
  }

  Future<void> _saveHobby() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newHobby = {
        'title': _titleController.text.trim(),
        'dailyHours': _hoursController.text.trim(),
        'description': _descriptionController.text.trim(),
      };

      _hobbies.add(newHobby);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('hobby', json.encode(_hobbies));

      // Clear fields after saving
      _titleController.clear();
      _hoursController.clear();
      _descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hobby added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF677E74);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Hobby'),
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
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Hobby Title'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hoursController,
                decoration: const InputDecoration(labelText: 'Daily Duration (in hours)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter duration' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveHobby,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Add Hobby',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              if (_hobbies.isNotEmpty)
                Text(
                  'Saved Hobbies (${_hobbies.length}):',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              for (var hobby in _hobbies)
                ListTile(
                  title: Text(hobby['title']),
                  subtitle: Text(
                      '${hobby['dailyHours']} hrs/day - ${hobby['description']}'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
