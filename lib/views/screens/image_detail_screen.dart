import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/show_toast.dart';
import 'package:pixel_perfect_wallpaper_app/functions/download_wallpaper.dart';

class ImageDetailScreen extends StatefulWidget {
  const ImageDetailScreen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  ShowToast toast = const ShowToast();
  DownloadWallpaper downloadWallpaper = DownloadWallpaper();

  // show progressbar on bottom sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Setting wallpaper..."),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Set image as wallpaper
  Future<void> setWallpaper(String setWallpaper, BuildContext ctx) async {
    try {
      int? location;
      if (setWallpaper == 'setLock') {
        location = WallpaperManager.LOCK_SCREEN;
      } else if (setWallpaper == 'setHome') {
        location = WallpaperManager.HOME_SCREEN;
      } else if (setWallpaper == 'setBoth') {
        location = WallpaperManager.BOTH_SCREEN;
      }

      // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);

      // Show the progress indicator
      _showBottomSheet(ctx);

      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location!);

      // Hide the progress indicator
      Navigator.of(ctx).pop();

      if (result) {
        await toast.showToast("Wallpaper set successfully");
        await Future.delayed(const Duration(seconds: 3));
      } else {
        toast.showToast("Failed to set wallpaper");
      }
    } on PlatformException catch (e) {
      print("Error setting wallpaper: ${e.message}");
    }
  }

  // Bottom popup
  void _showOptionsPopup(BuildContext con) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.screen_lock_portrait),
              title: const Text('Set as lock screen'),
              onTap: () {
                setWallpaper('setLock', context);
                Navigator.pop(con);
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Set as home screen'),
              onTap: () {
                setWallpaper('setHome', context);
                Navigator.pop(con);
              },
            ),
            ListTile(
              leading: const Icon(Icons.mobile_screen_share),
              title: const Text('Set both'),
              onTap: () {
                setWallpaper('setBoth', context);
                Navigator.pop(con);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 54.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // download btn
                    GestureDetector(
                      onTap: () {
                        downloadWallpaper.downloadAndSaveImage(widget.imageUrl);
                      },
                      child: GlassmorphicContainer(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        borderRadius: 60,
                        blur: 2,
                        border: 1,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.1),
                              const Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: const [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.5),
                            const Color((0xFFFFFFFF)).withOpacity(0.5),
                          ],
                        ),
                        child: const Icon(
                          Icons.download_rounded,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // apply btn
                    GestureDetector(
                      onTap: () {
                        _showOptionsPopup(context);
                      },
                      child: GlassmorphicContainer(
                        alignment: Alignment.center,
                        width: 160,
                        height: 48,
                        borderRadius: 24,
                        blur: 2,
                        border: 1,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.1),
                              const Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: const [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.5),
                            const Color((0xFFFFFFFF)).withOpacity(0.5),
                          ],
                        ),
                        child: Text(
                          'Apply',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w300,
                              fontSize: 22,
                              color: const Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                    //favorite btn
                    GestureDetector(
                      child: GlassmorphicContainer(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        borderRadius: 60,
                        blur: 2,
                        border: 1,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.1),
                              const Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: const [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.5),
                            const Color((0xFFFFFFFF)).withOpacity(0.5),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
