import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/Empty%20Home/EmptyHome.dart';
import 'dart:core';

import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Profile.dart';
import 'package:secure_hops/Widgets/navigator.dart';
showLoadingDialog(context) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(0, 30, 0, 30),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
        Text("Please Wait...")
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showErrorDialog(BuildContext context,List message,resturantId) {

  return Alert(
    // barrierDismissible: false,
    context: context,
    // type: AlertType.success,
    type: message.isEmpty ? AlertType.success : AlertType.error,
    title: message.isEmpty ? "Successfully Selected!" : "Complete Your Selection",
    style: AlertStyle(titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
    // desc: ListTile(title: message,),
    content: message.isEmpty ? Container(): FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
        for (var i in message)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("*",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(i),
            ],
          )
      ],),
    ),
    buttons: [
      DialogButton(
        color: message.isEmpty ? kCard1Color: kPrimaryColor,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          if(message.isEmpty){
           
          //  screenIndex = 0;
             push(context, ResturantProfile(resturantId: resturantId));
          //  if(provider.loginResponse == null){
          //    push(context, AppHomeAppHomePage()Page());
          //  }else{
          //    push(context, MyHomePage());
          //  }
          }else{
            pop(context);
          }
           
        },
        width: 120,
      )
    ],
  ).show();
}
