import 'package:flutter/material.dart';
import 'package:renounce/pages/home/home.dart';
import 'package:renounce/pages/onboarding/get_started.dart';
import 'package:renounce/utils/app_theme.dart';
import 'package:renounce/utils/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.loadThemePreference();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenIntro = prefs.containsKey('intro');

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Nairobi')); // or your actual timezone

  runApp(MyApp(initialPage: hasSeenIntro ? Home() : Onboarding()));
}

class MyApp extends StatelessWidget {
  final Widget initialPage;

  const MyApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: AppTheme.isDark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: AppTheme.background(),
        primaryColor: AppTheme.accentColour(),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: AppTheme.textColour()),
        ),
      ),
      home: initialPage,
    );
  }
}
