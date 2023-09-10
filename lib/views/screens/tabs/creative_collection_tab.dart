import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_perfect_wallpaper_app/data/tabs_list.dart';
import 'package:pixel_perfect_wallpaper_app/functions/open_image.dart';
import 'package:pixel_perfect_wallpaper_app/models/photos_model.dart';
import 'package:pixel_perfect_wallpaper_app/models/search_images_model.dart';
import 'package:pixel_perfect_wallpaper_app/services/fetch_images.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/no_internet_connection.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/shimmer_effect.dart';

class CreativeCollectionTab extends StatefulWidget {
  const CreativeCollectionTab({super.key});

  @override
  State<CreativeCollectionTab> createState() => _CreativeCollectionTabState();
}

class _CreativeCollectionTabState extends State<CreativeCollectionTab> {
  final OpenImage openImage = OpenImage();
  FetchImage fetchImage = FetchImage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SearchImagesModel>>(
      future: fetchImage.getTabPhotosAPI('creative'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerEffect();
          ;
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else {
          final images = snapshot.data!;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 13,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                mainAxisExtent: 400,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final imageUrl = images[index].src;
                return Hero(
                  tag: imageUrl,
                  child: GestureDetector(
                    onTap: () {
                      openImage.openImage(context, snapshot, index, imageUrl);
                    },
                    child: GridTile(
                      child: Container(
                        height: 800.0,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
