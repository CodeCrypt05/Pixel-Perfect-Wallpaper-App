import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/serach_result_screen.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/show_toast.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = " ";
  final _form = GlobalKey<FormState>();
  ShowToast toast = const ShowToast();

  onSearch(BuildContext context) {
    final isValid = _form.currentState!.validate();
    searchQuery = searchController.text;
    if (isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(
            searchQuery: searchQuery,
          ),
        ),
      );
    }
  }

  String? _validateSearch(String value) {
    if (value.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter a search query',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        textColor: Colors.white,
      );
      return null;
    }
    // You can add additional validation logic here
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Container(
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
                cursorColor: const Color.fromARGB(255, 37, 37, 37),
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
                validator: (value) {
                  if (value == null || value.trim().length < 2) {
                    return _validateSearch(value!);
                  }
                  return null;
                },
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
      ),
    );
  }
}
