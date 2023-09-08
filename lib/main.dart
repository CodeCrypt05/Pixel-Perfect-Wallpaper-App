import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const customColorScheme = ColorScheme.light(
      primary: Color.fromARGB(255, 255, 255, 255), // Example primary color
      secondary: Color.fromARGB(255, 255, 255, 255), // Example secondary color
      background: Colors.white, // Pure white background color
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: customColorScheme,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
