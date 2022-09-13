import 'package:flutter/material.dart';
import 'package:secure_hops/Widgets/theme.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              otpField1(),
              otpField2(),
              otpField3(),
              otpField4(),
              otpField5(),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  otpField1() {
    return SizedBox(
      width: (60),
      child: TextFormField(
        autofocus: true,
        obscureText: true,
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: otpInputDecoration,
        onChanged: (value) => nextField(value, pin2FocusNode),
      ),
    );
  }

  otpField2() {
    return SizedBox(
      width: (60),
      child: TextFormField(
        focusNode: pin2FocusNode,
        obscureText: true,
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: otpInputDecoration,
        onChanged: (value) => nextField(value, pin3FocusNode),
      ),
    );
  }

  otpField3() {
    return SizedBox(
      width: (60),
      child: TextFormField(
        focusNode: pin3FocusNode,
        obscureText: true,
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: otpInputDecoration,
        onChanged: (value) => nextField(value, pin4FocusNode),
      ),
    );
  }

  otpField4() {
    return SizedBox(
      width: (60),
      child: TextFormField(
        focusNode: pin4FocusNode,
        obscureText: true,
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: otpInputDecoration,
        onChanged: (value) => nextField(value, pin5FocusNode),
      ),
    );
  }

  otpField5() {
    return SizedBox(
      width: (60),
      child: TextFormField(
        focusNode: pin5FocusNode,
        obscureText: true,
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: otpInputDecoration,
        onChanged: (value) {
          if (value.length == 1) {
            pin5FocusNode!.unfocus();
            // Then you need to check is the code is correct or not
          }
        },
      ),
    );
  }
}
