import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_wallpaper_app/data/tabs_list.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          items[current] + 'Welcome',
          style: GoogleFonts.laila(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: Colors.deepPurple),
        ),
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.green,
        )
      ],
    );
  }
}
