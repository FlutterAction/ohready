import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/User/user.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Widgets/Material%20Color.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/TextField.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/loading.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import '../../../Components/constants.dart';
import '../Login/Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  String? facebookId, googleId;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size  = MediaQuery.of(context).size;
    return  Scaffold(
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
                height: size.height*0.70,
                width: size.width,
                decoration: BoxDecoration(
                color: Color(0xffff0018),
                image: DecorationImage(image: AssetImage("assets/BGcirclrs.png")),
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
              Container(
                width: size.width * 0.90,
                height: 620,
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
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40,left: 10),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,bottom: 10),
                              child: Text("Email Address",style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xffff0018)),),
                            ),
                            emailField(),
                              Padding(
                              padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                              child: Text("Password",style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xffff0018)),),
                            ),
                            passwordField(),
                             Padding(
                              padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                              child: Text("Confirm Password",style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xffff0018)),),
                            ),
                            cPasswordField(),
                            
                            // SizedBox(
                            //   height: size.height / 10,
                            // ),
                            signinButton(),
                            signupButton(),
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
        
            ],
          ),
        ),
      ),
    );
   }

  signUpForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                usernameField(),
                emailField(),
                passwordField(),
                cPasswordField(),
                SizedBox(height: SizeConfig.screenHeight! / 14),
                signupButton(),
                signinButton(),
                Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
                socialLogin()
              ],
            ),
          )),
    );
  }

  usernameField() {
    return TextFormField(
      controller: userName,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffff0018)),
        ),
        border: UnderlineInputBorder(),
        labelText: 'Username',
      ),
      obscureText: false,
    );
  }

  emailField() {
    return CustomTextField(
        controller: userName,
        error: 'Please enter email or username',
        labelText: 'Email / Username',
        obscureText: false); }

    googleButton() {
    return InkWell(
      onTap: (){
        //  signInWithGoogle();
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
            height: 25,width: 25,
            child: Image.asset("assets/google.png",)),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text("Login with Google",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,),),
          )

        ],),
      ),
    );
  }


   facebookButton() {
    return InkWell(
      onTap:(){},
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
            height: 25,width: 25,
            child: Image.asset("assets/facebook.png",)),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text("Login with Facebook",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
          )

        ],),
      ),
    );
  }


  passwordField() {
    return CustomTextField(
        controller: password,
        error: 'Please enter Password',
        labelText: 'Password',
        obscureText: true); }

  cPasswordField() {
    return CustomTextField(
        controller: confirmPassword,
        error: 'Please enter Password',
        labelText: 'Password',
        obscureText: true); }

  signupButton() {
    return MyButton(
        text: "Signup",
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            trySignup();
          }
        });
  }

  signinButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text("Already have account?", style: TextStyle(color: Colors.grey)),
          TextButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (_) => Login());
                Navigator.pushReplacement(context, route);
              },
              child: Text("Sign in.",
                  style: TextStyle(
                      color: Color(0xffff0018), fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  socialLogin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {},
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

  trySignup() {
    showLoadingDialog(context);
    return APIManager()
        .signup(context,
            email: email.text.trim(),
            password: password.text,
            username: userName.text.trim())
        .then((response) async {
      pop(context);
      executeResponse(response);
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

      rootPush(context, MyHomePage());
    }

    // if result is alreadyEmail then email already exists
    else if (loginResponse.user!.result == 'alreadyEmail') {
      return CustomSnackBar.show(context, "Email alreay exists.");
    }

    // if result is alreadyName then userName already exists
    else if (loginResponse.user!.result == 'alreadyName') {
      return CustomSnackBar.show(context, "Username alreay exists.");
    }

    // if result is error then there is some error
    else if (loginResponse.user!.result == 'error') {
      return CustomSnackBar.show(
          context, "Unable to register. Please try again.");
    }
  }
}
