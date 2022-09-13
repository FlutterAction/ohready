import 'package:flutter/material.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import '../../../Components/constants.dart';
import 'Components/otp_form.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: appBar(context, title: "Verify Your Phone Number"),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Enter your OTP code here"),
                  ],
                ),
                SizedBox(height: 20),
                OtpForm(),
                SizedBox(height: 20),
                resendOTP(),
                SizedBox(
                  height: 40,
                ),
                MyButton(
                    text: 'VERIFY',
                    onPressed: () {
                      push(context, MyHomePage());
                    })
              ],
            ),
          ),
        ));
  }

  Widget otpTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Enter your OTP here"),
      ],
    );
  }

  resendOTP() {
    return Row(
      children: [
        Text(
          "Didn't receive the OTP? ",
          style: TextStyle(color: textColor),
        ),
        GestureDetector(
          onTap: () {
            print("Code resended");
          },
          child: Text(
            "Resend.",
            style: TextStyle(
                decoration: TextDecoration.underline, color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
