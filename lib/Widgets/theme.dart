import 'package:flutter/material.dart';
import 'package:secure_hops/Components/constants.dart';

final otpInputDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular((15)),
    borderSide: BorderSide(color: Colors.redAccent),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: (15)),
  border: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((15)),
    borderSide: BorderSide(color: textColor),
  );
}
