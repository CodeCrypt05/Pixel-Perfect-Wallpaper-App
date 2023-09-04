import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/functions/open_image.dart';
import 'package:pixel_perfect_wallpaper_app/models/photos_model.dart';
import 'package:pixel_perfect_wallpaper_app/services/fetch_images.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/no_internet_connection.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.query});
  final String query;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final OpenImage openImage = OpenImage();
  late List<PhotosModel> searchResult;
  FetchImage fetchImage = FetchImage();

  void getSearchWallPapers(String query) async {
    searchResult = await fetchImage.getTabPhotosAPI(query);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallPapers(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PhotosModel>>(
      future: fetchImage.getTabPhotosAPI(widget.query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else {
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
                return Hero(
                  tag: snapshot.data![index].portrait.toString(),
                  child: GestureDetector(
                    onTap: () {
                      openImage.openImage(context, snapshot, index);
                    },
                    child: GridTile(
                      child: Container(
                        height: 800.0,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                searchResult[index].portrait.toString()),
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
