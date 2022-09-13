import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Widgets/navigator.dart';

InputBorder? focusedBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: kPrimaryColor),
);

String convertPrice(BuildContext context, price) {
  Locale locale = Localizations.localeOf(context);
  NumberFormat format = NumberFormat.simpleCurrency(locale:'ES');
  return format.format(price);
}

 customPOP(context){
   return InkWell(
            onTap: (){
               MyProvider provider =
                      Provider.of<MyProvider>(context, listen: false);
                  provider.saveItemList(null);
                  pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration:BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(50)
              ),
                padding: EdgeInsets.all(5),
                
              child:
                  Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                  )
            ),
          );
      
 }




  customRoutePOP(context,route){
   return InkWell(
            onTap: (){
              //  MyProvider provider =
              //         Provider.of<MyProvider>(context, listen: false);
              //     provider.saveItemList(null);
              
                  push(context, route);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration:BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(50)
              ),
                padding: EdgeInsets.all(5),
                
              child:
                  Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                  )
            ),
          );
      
 }