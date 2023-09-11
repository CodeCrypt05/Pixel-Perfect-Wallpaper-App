import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/functions/open_image.dart';
import 'package:pixel_perfect_wallpaper_app/models/search_images_model.dart';
import 'package:pixel_perfect_wallpaper_app/services/fetch_images.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/no_internet_connection.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/shimmer_effect.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/show_toast.dart';

class CreativeCollectionTab extends StatefulWidget {
  const CreativeCollectionTab({super.key});

  @override
  State<CreativeCollectionTab> createState() => _CreativeCollectionTabState();
}

class _CreativeCollectionTabState extends State<CreativeCollectionTab> {
  final OpenImage openImage = OpenImage();
  FetchImage fetchImage = FetchImage();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int page = 1; // Start with the first page
  List<SearchImagesModel> images = [];
  final String tabType = 'Creative';
  ShowToast toast = const ShowToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        loadNextPage();
      }
      if (_scrollController.position.pixels == 0.0 && !isLoading) {
        loadPreviousPage();
      }
    });
  }

  Future<void> loadNextPage() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Make your API call with an increased page count
      final newImages = await fetchImage.getTabPhotosAPI(tabType, page + 1);

      setState(() {
        isLoading = false;
        page++; // Increment the page count
        // Append the new images to your existing list of images
        images.addAll(newImages);
        toast.showToast('Page No:$page');
      });
    } catch (error) {
      // Handle the error
      print('Error loading more data: $error');
    }
  }

  Future<void> loadPreviousPage() async {
    if (page > 1) {
      setState(() {
        isLoading = true;
      });

      try {
        // Make your API call with a decreased page count
        final previousImages =
            await fetchImage.getTabPhotosAPI(tabType, page - 1);

        setState(() {
          isLoading = false;
          page--; // Decrease the page count
          // Prepend the new images to your existing list of images
          images.insertAll(0, previousImages);
          toast.showToast('Page No:$page');
        });
      } catch (error) {
        // Handle the error
        print('Error loading previous page data: $error');
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SearchImagesModel>>(
      future: fetchImage.getTabPhotosAPI(tabType, page),
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
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
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
