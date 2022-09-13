import 'package:flutter/material.dart';

rootPush(BuildContext context, Widget page) {
  return Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (builder) => page));
}

pushAndRemoveUntil(BuildContext context, Widget page) {
  return Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (builder) => page), (route) => false);
}

push(BuildContext context, Widget page) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (builder) => page));
}

pop(BuildContext context) {
  return Navigator.pop(context);
}
