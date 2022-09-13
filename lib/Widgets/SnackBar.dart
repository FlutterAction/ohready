import 'package:flutter/material.dart';

class CustomSnackBar {
  final String? message;

  const CustomSnackBar({
    @required this.message,
  });

  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      // action: SnackBarAction(
      //   textColor: Color(0xFFFAF2FB),
      //   label: 'OK',
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //   },
      // ),
    ));
  }
}
