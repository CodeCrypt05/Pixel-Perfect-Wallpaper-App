import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  Future<void> _navigateHome() async {
    await Future.delayed(const Duration(seconds: 5));

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/logo.png', // Make sure this path is correct
        width: 150,
        height: 150,
      ),
    ));
  }
}
