import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/functions/open_image.dart';
import 'package:pixel_perfect_wallpaper_app/data/models/photos_model.dart';
import 'package:pixel_perfect_wallpaper_app/data/services/fetch_images.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/no_internet_connection.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/shimmer_effect.dart';

class TrendingTab extends StatefulWidget {
  const TrendingTab({super.key});

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
  final OpenImage openImage = OpenImage();
  FetchImage fetchImage = FetchImage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PhotosModel>>(
      future: fetchImage.getRandomPhotosAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerEffect();
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else {
          final images = snapshot.data!;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 13,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                mainAxisExtent: 400,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final imageUrl = images[index].portrait;
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
                          color: Colors.grey.shade300,
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
