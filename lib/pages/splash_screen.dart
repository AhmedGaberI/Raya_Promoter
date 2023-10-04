import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:promoter_tracking_app/pages/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashTransition: SplashTransition.slideTransition,
        splashIconSize: double.infinity,
        duration: 4000,
        splash: 'assets/images/LOGO.jpg',
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        nextScreen: const HomePage(),
      ),
    );
  }
}
