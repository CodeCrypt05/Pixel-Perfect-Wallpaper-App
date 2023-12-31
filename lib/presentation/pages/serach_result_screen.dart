import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/functions/open_image.dart';
import 'package:pixel_perfect_wallpaper_app/data/models/search_images_model.dart';
import 'package:pixel_perfect_wallpaper_app/data/services/fetch_images.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/no_result_found.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/search_bar.dart';
import 'package:pixel_perfect_wallpaper_app/presentation/widgets/shimmer_effect.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;
  const SearchResultScreen({super.key, required this.searchQuery});

  @override
  State<SearchResultScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchResultScreen> {
  final OpenImage openImage = OpenImage();
  late List<SearchImagesModel> searchResult;
  FetchImage fetchImage = FetchImage();
  bool isLoading = true;

  void getSearchWallPapers() async {
    searchResult = await fetchImage.getSearchPhotosAPI(widget.searchQuery);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallPapers();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.06,
              child: const SearchBarWidget(),
              // color: Colors.amber,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Flexible(
                    flex: 99,
                    child: _searchResult(context),
                  ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<SearchImagesModel>> _searchResult(BuildContext context) {
    return FutureBuilder<List<SearchImagesModel>>(
      future: fetchImage.getSearchPhotosAPI(widget.searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: ShimmerEffect(),
          );
        } else if (snapshot.hasError || snapshot.data!.isEmpty) {
          return const NoResultFound();
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
                          color: Colors.grey.shade300,
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
