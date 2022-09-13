import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'Resturant Details/Resturant Details.dart';

class ResturantInfo extends StatelessWidget {
  final ResturantProfileModel? resturantProfile;
  ResturantInfo({@required this.resturantProfile});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        push(context, ResturantDetails(resturantProfile: resturantProfile));
      },
      child: Container(
        
        margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
        height: size.height * 0.15,
        // color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
         
            Container(
              // color: Colors.red,
              width: size.width / 1.3,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: getProportionateScreenWidth(222),
                      child: Text(resturantProfile!.name.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(children: [
                      Text("0.2 Km away | Rating: ${resturantProfile!.rating} | Delivery Charges ${convertPrice(context,resturantProfile!.deliveryCharges)} ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              )),
                          //     Text("0.2 Km",
                          // overflow: TextOverflow.ellipsis,
                          // style: TextStyle(
                          //     fontSize: 10,
                          //     color: Colors.black,
                          //     )),
                    ],)
                    // Container(
                    //   padding: EdgeInsets.only(top: 5),
                    //   width: size.width / 1.7,
                    //   child: Text(
                    //     resturantProfile!.foodTypes.toString(),
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: TextStyle(color: Colors.black, fontSize: 16),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  push(context,
                      ResturantDetails(resturantProfile: resturantProfile));
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }

  String convertPrice(BuildContext context, price) {
  Locale locale = Localizations.localeOf(context);
  NumberFormat format = NumberFormat.simpleCurrency(locale:'ES');
  return format.format(price);
}
}
