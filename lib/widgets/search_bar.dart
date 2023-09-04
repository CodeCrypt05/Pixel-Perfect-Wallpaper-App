import 'package:flutter/material.dart';
import 'package:pixel_perfect_wallpaper_app/views/screens/serach_screen.dart';
import 'package:pixel_perfect_wallpaper_app/widgets/show_toast.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _focusNode;
  bool _isTextFieldFocused = true;
  final _formKey = GlobalKey<FormState>();
  ShowToast toast = const ShowToast();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _openKeyboard() {
    setState(() {
      _isTextFieldFocused = true;
    });
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _closeKeyboardAndUnfocus() {
    _focusNode.unfocus();
    setState(() {
      _isTextFieldFocused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
              child: GestureDetector(
                onTap: _closeKeyboardAndUnfocus,
                child: TextFormField(
                  controller: _searchController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a search query';
                    }
                    return null;
                  },
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
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // Check if the form is valid
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(query: _searchController.text),
                    ),
                  );
                }
              },
              child: const Icon(Icons.search),
            )
          ],
        ),
      ),
    );
  }
}
