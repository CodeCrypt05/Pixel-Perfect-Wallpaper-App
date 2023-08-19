import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _focusNode;
  bool _isTextFieldFocused = false;

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
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 10,
      width: 100,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _closeKeyboardAndUnfocus,
              child: TextField(
                showCursor: _isTextFieldFocused,
                autofocus: _isTextFieldFocused,
                controller: _searchController,
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         SearchScreen(query: _searchController.text),
                //   ),
                // );
              },
              child: Icon(Icons.search))
        ],
      ),
    );
  }
}
