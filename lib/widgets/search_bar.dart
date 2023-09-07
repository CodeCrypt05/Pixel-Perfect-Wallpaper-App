import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/serach_result_screen.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = " ";

  onSearch(BuildContext context) {
    searchQuery = searchController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(
          searchQuery: searchQuery,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 10,
      width: 100,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (String value) {
                onSearch(context);
                searchController.clear();
              },
              controller: searchController,
              decoration: const InputDecoration(
                hintText: "Search Wallpapers",
                hintStyle: TextStyle(color: Colors.grey),
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
              onTap: () => {
                    onSearch(context),
                    searchController.clear(),
                  },
              child: const Icon(Icons.search))
        ],
      ),
    );
  }
}
