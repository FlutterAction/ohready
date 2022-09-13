import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Modals/Customer%20Profile/CustomerProfile.dart';
import 'package:secure_hops/Modals/User/user.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Widgets/AppBar.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import '../../../Components/constants.dart';

class ChangePassword extends StatefulWidget {
  final CustomerProfile? profile;
  ChangePassword({@required this.profile});
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(context, title: 'Change Password'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                imageWidget(),
                box,
                Form(
                  key: _formKey,
                  child: Column(children: [
                    oldPasswordField(),
                    box,
                    newPasswordField(),
                    box,
                    confirmPasswordField(),
                  ]),
                ),
                box,
                box,
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                box,
                MyButton(
                    text: 'SAVE PASSWORD',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        tryChangePass();
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  imageWidget() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.network(
                  widget.profile!.profilePicturePath ?? demoAvatar,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }

  oldPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedBorder,
        hintText: "Enter old password",
        hintStyle: TextStyle(color: Colors.grey),
        labelText: "Old Password",
      ),
      controller: oldPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter old Password';
        }

        return null;
      },
    );
  }

  newPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedBorder,
        hintText: "Enter new password",
        hintStyle: TextStyle(color: Colors.grey),
        labelText: "New PassWord",
      ),
      controller: newPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter new Password';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters long';
        }

        return null;
      },
    );
  }

  confirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedBorder,
        hintText: "Enter confirm password",
        hintStyle: TextStyle(color: Colors.grey),
        labelText: "Confirm PassWord",
      ),
      controller: confirmPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter confirm Password';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        if (newPassword.text != confirmPassword.text) {
          return 'Password does not match!';
        }
        return null;
      },
    );
  }

  Widget box = SizedBox(
    height: 25,
  );

  tryChangePass() {
    setState(() {
      isLoading = true;
    });

    APIManager()
        .changepass(context,
            oldpass: oldPassword.text,
            newpass: newPassword.text,
            usercode: widget.profile!.customerCode)
        .then((response) {
      setState(() {
        isLoading = false;
      });
      executeResponse(response);
    });
  }

  executeResponse(Response response) {
    var result = json.decode(response.body);

    // if result is true password change successfully
    if (result['result'] == 'true') {
      CustomSnackBar.show(context, 'Password changed successfully!');
      updateData();
      pop(context);
    }

    // if result is OldPassWrong then password is wrong
    else if (result['result'] == 'OldPassWrong') {
      CustomSnackBar.show(context, 'Wrong old password!');
    }
  }

  updateData() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);

    // new login response
    LoginResponse loginResponse = LoginResponse.fromJson(
        provider.loginResponse!.user!.toJson(), newPassword.text);

    // save new login response
    provider.saveLoginResponse(loginResponse);
  }
}
