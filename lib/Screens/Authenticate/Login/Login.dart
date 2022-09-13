import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Modals/User/user.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Authenticate/Facebook/facebook_login.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/TextField.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/loading.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/app_localization.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import '../../../Components/constants.dart';
import '../Reset Password/ForgotPassword.dart';
import '../Signup/SignUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -100,
                child: Container(
                  height: size.height * 0.70,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffff0018),
                      image: DecorationImage(
                          image: AssetImage("assets/BGcirclrs.png")),
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
              Container(
                width: size.width * 0.90,
                height: 500,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 10),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                "Email Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffff0018)),
                              ),
                            ),
                            emailField(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 10, top: 10),
                              child: Text(
                                AppLocalizations.of(context).translate("password"),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffff0018)),
                              ),
                            ),
                            passwordField(),
                            forgotPasswordButton(),
                            // SizedBox(
                            //   height: size.height / 10,
                            // ),
                            signinButton(),
                            facebookButton(),
                            googleButton(),
                            // Divider(
                            //   height: 1.5,
                            //   color: Colors.grey,
                            // ),
                            // socialLoginButton()
                          ],
                        )),
                  ],
                ),
              ),
              Positioned(
                bottom: 50,
                child: signupButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  emailField() {
    return CustomTextField(
        controller: userName,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Empty";
          }
          if(!value.contains("@") && !value.contains(".com")  ){
             return "Add @ or .com";
          }
          return null;
        },
        error: 'Please enter email or username',
        labelText: 'Email / Username',
        obscureText: false);
  }

  passwordField() {
    return CustomTextField(
      validator: (value){
        if(value.length < 7){
          return "Password must have at least 6 character";
        }
      },
        controller: password,
        error: 'Please enter Password',
        labelText: 'Password',
        obscureText: true);
  }

  forgotPasswordButton() {
    return Container(
      // color: Color(0xffff0018),
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () {
            push(context, ForgotPassword());
          },
          child: Text(
            "Forgot password?",
            style: TextStyle(color: Colors.grey[400]),
          )),
    );
  }

  signinButton() {
    return MyButton(
        text: AppLocalizations.of(context).translate('signin'),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            trySignin();
          }
        });
  }

  googleButton() {
    return InkWell(
      onTap: () {
        googleSignin();
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
        
          color: Colors.white24,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 25,
                width: 25,
                child: Image.asset(
                  "assets/google.png",
                )),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Login with Google",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  facebookButton() {
    return InkWell(
      onTap: () {
        SocialLogin().signInWithFacebook();
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 25,
                width: 25,
                child: Image.asset(
                  "assets/facebook.png",
                )),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Login with Facebook",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  signupButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text("Don't have account?", style: TextStyle(color: Colors.grey)),
          TextButton(
              onPressed: () {
                push(context, SignUp());
              },
              child: Text("Sign up.",
                  style: TextStyle(
                      color: Color(0xffff0018), fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  socialLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Facebook Login
          GestureDetector(
            onTap: () async {},
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: new BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.indigo,
                ),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/facebooklogo.png",
                height: 20,
                width: 20,
              ),
            ),
          ),

          //Google Login
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                signInWithGoogle();
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: new BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color(0xffff0018),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/google.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  trySignin() {
    showLoadingDialog(context);
    return APIManager()
        .singin(context, userName: userName.text, password: password.text)
        .then((response) async {
      print(response.body);
      pop(context);
      return executeResponse(response);
    });
  }

  executeResponse(Response response) async {
    var jsonMap = json.decode(response.body);
    LoginResponse loginResponse =
        LoginResponse.fromJson(jsonMap, password.text);

    // if result is true then user registered successfully
    if (loginResponse.user!.result == 'true') {
      //save login response
      MyProvider provider = Provider.of<MyProvider>(context, listen: false);
      provider.saveLoginResponse(loginResponse);
      //navigate to home screen
      return rootPush(context, MyHomePage());
    }

    // if result is not true then show error
    else {
      return CustomSnackBar.show(context, "Wrong Email or Password");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  googleSignin() async {
      // showLoadingDialog(context);
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '375296455242-ackbrjeog6kp4vor02rbn3ccdd0mq5h2.apps.googleusercontent.com',
    );
    GoogleSignInAccount? user = await googleSignIn.signIn();
    // print(user!.displayName);

      // pop(context);
    return APIManager()
        .singin(context,            
            userName: user!.email,
            password: user.id,)
        .then((response) async {
      print(response.body);

      // executeResponse(response);
    });


  }
}
