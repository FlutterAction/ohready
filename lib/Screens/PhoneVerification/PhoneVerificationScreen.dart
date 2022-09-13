import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import '../../Components/constants.dart';
import 'OTP/OtpScreen.dart';

class PhoneverificationScreen extends StatefulWidget {
  @override
  _PhoneverificationScreenState createState() =>
      _PhoneverificationScreenState();
}

class _PhoneverificationScreenState extends State<PhoneverificationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String phoneN = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(context, title: "Verify Your Phone Number"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                codeSentWidget(),
                SizedBox(
                  height: 40,
                ),
                phoneNoWidget(),
                phoneField(),
                SizedBox(
                  height: 20,
                ),
                confirmButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  codeSentWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        "We have sent you an sms with a code to number " + phoneN,
        style: TextStyle(color: textColor),
      ),
    );
  }

  phoneNoWidget() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "PHONE NUMBER",
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }

  phoneField() {
    return IntlPhoneField(
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        labelText: 'Phone Number',
        border: UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      onChanged: (phone) {
        setState(() {
          phoneN = phone.completeNumber;
        });
        print(phone.completeNumber);
      },
      onCountryChanged: (phone) {
        print('Country code changed to: ' + phone.countryCode.toString());
      },
    );
  }

  confirmButton() {
    return MyButton(
        text: "CONFIRM",
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            push(context, OtpScreen());
          }
        });
  }
}
