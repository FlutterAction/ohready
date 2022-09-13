import 'package:flutter/material.dart';
import '../Components/constants.dart';

PreferredSizeWidget appBar(BuildContext context, {@required String? title}) {
  return AppBar(
      iconTheme: IconThemeData.fallback(),      
      automaticallyImplyLeading: true,
      leading: IconButton(
        padding: EdgeInsets.all(10),
        color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color:Colors.red,)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title.toString(),
        style: TextStyle(color: appBarText),
      ));
}
