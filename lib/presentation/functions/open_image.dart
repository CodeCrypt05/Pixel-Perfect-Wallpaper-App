import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/pages/image_detail_screen.dart';

class OpenImage {
  void openImage(
      BuildContext context, dynamic snapshot, int index, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
