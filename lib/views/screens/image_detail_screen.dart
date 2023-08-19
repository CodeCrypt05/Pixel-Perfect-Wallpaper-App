import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageDetailScreen extends StatefulWidget {
  const ImageDetailScreen({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  String _platformVersion = 'Unknown';
  String __heightWidth = "Unknown";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAppState();
  }

  Future<void> initAppState() async {
    String platformVersion;
    String _heightWidth;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await WallpaperManager.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      int height = await WallpaperManager.getDesiredMinimumHeight();
      int width = await WallpaperManager.getDesiredMinimumWidth();
      _heightWidth =
          "Width = " + width.toString() + " Height = " + height.toString();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      _heightWidth = "Failed to get Height and Width";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      __heightWidth = _heightWidth;
      _platformVersion = platformVersion;
    });
  }

  // Set image as wallpaper
  Future<void> setWallpaper(String setWallpaper) async {
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
      bool progressVisible = true;
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext context) {
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
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location!);

      // Hide the progress indicator
      Navigator.of(context).pop();
      if (result) {
        await _showToast("Wallpaper set successfully");
        await Future.delayed(Duration(seconds: 2));
      } else {
        _showToast("Failed to set wallpaper");
      }
    } on PlatformException catch (e) {
      print("Error setting wallpaper: ${e.message}");
    }
  }

  // Bottom popup
  void _showOptionsPopup(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.screen_lock_portrait),
                title: const Text('Set as lock screen'),
                onTap: () {
                  setWallpaper('setLock');
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Set as home screen'),
                onTap: () {
                  setWallpaper('setHome');
                },
              ),
              ListTile(
                leading: const Icon(Icons.mobile_screen_share),
                title: const Text('Set both'),
                onTap: () {
                  setWallpaper('setBoth');
                },
              ),
            ],
          ),
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
                            stops: [
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
                            stops: [
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

  // Toast Message
  Future<bool?> _showToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
