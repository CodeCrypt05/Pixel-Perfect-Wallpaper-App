import 'package:flutter/material.dart';

class NoResultFound extends StatelessWidget {
  const NoResultFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Results Found!",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            "Try a different search query or check for typos.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
