import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/show_toast.dart';

class DownloadWallpaper {
  ShowToast toast = const ShowToast();
  // Download and Save Image
  Future<void> downloadAndSaveImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/image.jpg';

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveFile(filePath);

      if (result['isSuccess']) {
        toast.showToast('Image saved to gallery');
      } else {
        toast.showToast('Failed to save image to gallery');
      }
    }
  }
}
