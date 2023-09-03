import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/image_detail_screen.dart';

class OpenImage {
  void openImage(BuildContext context, dynamic snapshot, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(
          imageUrl: snapshot.data![index].portrait.toString(),
        ),
      ),
    );
  }
}
