import 'package:flutter/material.dart';
import 'package:renounce/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  bool _isLastPage = false;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/onboarding1.jpg',
      'title': 'Welcome to ZenSpace',
      'text': 'Your journey to better wellness starts here.',
    },
    {
      'image': 'assets/onboarding2.jpg',
      'title': 'Mind & Body Harmony',
      'text': 'Discover guided meditations and calming exercises.',
    },
    {
      'image': 'assets/onboarding3.jpg',
      'title': 'Track Your Progress',
      'text': 'Stay motivated and achieve your personal goals.',
    },
  ];

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('intro', 'completed');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = Color(0xFF677E74);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() => _isLastPage = index == _pages.length - 1);
            },
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(page['image']!, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      page['title']!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      page['text']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              );
            },
          ),

          // Smooth sticky indicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: _pages.length,
                effect: WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  type: WormType.thinUnderground,
                  activeDotColor: accent,
                  dotColor: Colors.grey.shade300,
                ),
              ),
            ),
          ),

          // Get Started Button
          if (_isLastPage)
            Positioned(
              bottom: 20,
              left: 24,
              right: 24,
              child: ElevatedButton(
                onPressed: _completeOnboarding,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }
}
