import 'package:flutter/material.dart';

class AbpoutUsScreen extends StatelessWidget {
  const AbpoutUsScreen({super.key});

  static const String welcomeMessage =
      'Welcome to Pixel Perfect Wallpaper, your go-to destination for stunning high-quality wallpapers that transform your device\'s screen into a work of art.';
  static const String missionStatement =
      'Our mission is to bring creativity and inspiration to your daily life through carefully curated wallpapers across various categories, from breathtaking nature scenes to captivating abstract art.';
  static const String aboutContent =
      'We take pride in offering a diverse selection of wallpapers that cater to different tastes and moods. Our team is dedicated to continuously expanding our library, ensuring that you always have access to the latest trends and timeless classics.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 62,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Pixel Perfect Wallpapers",
              style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, right: 18),
              child: const Column(
                children: [
                  Text(
                    welcomeMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    missionStatement,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    aboutContent,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 84,
                  ),
                  Text(
                    "Version 1.0.1",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
