import 'package:flutter/material.dart';
import 'home.dart';

class SurveyLoadingScreen extends StatefulWidget {
  const SurveyLoadingScreen({super.key});

  @override
  State<SurveyLoadingScreen> createState() => _SurveyLoadingScreenState();
}

class _SurveyLoadingScreenState extends State<SurveyLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();
    
    // Set up breathing animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _breathingAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    // Start the breathing animation and repeat
    _controller.repeat(reverse: true);
    
    // Navigate to home page after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeMenu()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Breathing logo animation
            AnimatedBuilder(
              animation: _breathingAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _breathingAnimation.value,
                  child: Image.asset(
                    'assets/logomini.png',
                    height: 100,
                    width: 100,
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            // Loading text
            const Text(
              'Generating Personalized Page...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}