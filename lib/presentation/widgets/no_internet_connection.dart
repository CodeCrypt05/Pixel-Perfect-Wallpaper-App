import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 160,
          width: 160,
          child: Image.asset('assets/images/no_internet_connection.png'),
        ),
        const Text(
          "Oh Shucks!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text(
          textAlign: TextAlign.center,
          "Slow or no internet connection\nPlease check your internet setting",
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(122, 32, 32, 32),
          ),
        ),
      ],
    );
  }
}
