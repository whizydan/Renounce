import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final Color accent = const Color(0xFF677E74);

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Notifications')),
    Center(child: Text('Growth Tracking')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _navItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? accent : Colors.grey,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: accent,
        unselectedItemColor: Colors.grey,
        items: [
          _navItem(Icons.home_rounded, 'Home', 0),
          _navItem(Icons.notifications_rounded, 'Notifications', 1),
          _navItem(Icons.bar_chart_rounded, 'Growth', 2),
        ],
      ),
    );
  }
}
