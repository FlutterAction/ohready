import 'package:flutter/material.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import '../../../Components/Images.dart';
import '../../../Components/constants.dart';
import 'ResetPassword.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(context, title: "Forgot Password"),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              "Please enter your email address. You will recieve a link to create a new password via email.",
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            TextField(
              controller: _emailTextEditingController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Email'),
              obscureText: false,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => ResetPassword());
                    Navigator.push(context, route);
                  },
                  child: Stack(
                    children: [
                      Container(
                        child: Image.asset(btn),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 130),
                        child: Text(
                          "SEND",
                          style: TextStyle(
                              color: btntextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                )
                // ElevatedButton(
                //   child: Text("SEND",style: TextStyle(color: Colors.white),),
                //   onPressed: (){
                //     Route route=MaterialPageRoute(builder: (_)=>ResetPassword());
                //     Navigator.pushReplacement(context, route);
                //   },
                //   style: ElevatedButton.styleFrom(
                //       primary: Colors.redAccent,
                //       padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                //       textStyle: TextStyle(
                //           fontSize: 30,
                //           fontWeight: FontWeight.bold)),
                //
                //
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
