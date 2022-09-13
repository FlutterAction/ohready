import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? error, labelText;
  final bool? obscureText;
  final validator;
  const CustomTextField(
      {@required this.controller,
      @required this.error,
      @required this.labelText,
      @required this.obscureText,
       this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100)
      ),
      child: TextFormField(        
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          isDense: true,
          hintText: labelText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(100)
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100)
          ),
          // labelText: labelText,
        ),
        obscureText: obscureText!,
      ),
    );
  }
}
