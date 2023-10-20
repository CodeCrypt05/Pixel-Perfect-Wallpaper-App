import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast extends StatelessWidget {
  const ShowToast({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  // Toast Message
  Future<bool?> showToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      textColor: Colors.white,
    );
  }
}
