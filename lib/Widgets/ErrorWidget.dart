import 'package:flutter/material.dart';

class ServerError extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  ServerError({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(onPressed: onPressed, icon: Icon(Icons.refresh_outlined)),
        SizedBox(
          height: 5,
        ),
        Text(
          text.toString(),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
