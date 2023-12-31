import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/pages/splash_screen.dart';

var devices = ["4F60027F3F6991DF5655BEE2900555A1"];
Future<void> main() async {
  await dotenv.load(fileName: ".env");

  // SDK Initialization
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // this function requires for test ads
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  //This below function use for check device preview

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: ((context) => const MyApp()),
  //   ),
  // );
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
      background:
          Color.fromARGB(255, 255, 255, 255), // Pure white background color
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: customColorScheme,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
