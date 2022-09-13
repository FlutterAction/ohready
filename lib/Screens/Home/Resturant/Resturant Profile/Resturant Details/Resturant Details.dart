import 'package:flutter/material.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Widgets/OpenMaps.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

class ResturantDetails extends StatelessWidget {
  final ResturantProfileModel? resturantProfile;
  const ResturantDetails({@required this.resturantProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            resturantBanner(),
            backButton(context),

            //Resturant Logo
            Positioned(
                right: getProportionateScreenWidth(20),
                top: getProportionateScreenHeight(150),
                child: Padding(
                   padding: const EdgeInsets.only(left: 15.0),
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(100),
                       border: Border.all(color: Colors.red),
                     ),
                     child: CircleAvatar(
                       backgroundImage:
                           NetworkImage(resturantProfile!.logo.toString()),
                       radius: 40,
                     ),
                   ),
                 ),),

            //Resturant Details
            DefaultTabController(
              initialIndex: 0,              
              length: 2,              
              child: Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(230)),
                child: SingleChildScrollView(
                  child: Column(
                                        
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TabBar(
                        indicatorColor: primaryColor,
          labelColor: Colors.black45,
          tabs: [
            Padding(padding: const EdgeInsets.only(top: 12, bottom: 12), child: Text('Details')),
            Padding(padding: const EdgeInsets.only(top: 12, bottom: 12), child: Text('Reviews')),
          ],
        ),
                      //Resturant Name
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, size: 14),
                            SizedBox(width: 10),
                            Text(
                              '${resturantProfile!.name}',
                              style:
                                  TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      //Resturant Address
                      InkWell(
                        onTap: () {
                          MapUtils.openMap(resturantProfile!.locLat!,
                              resturantProfile!.locLng!);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Icon(Icons.location_pin, size: 14),
                              SizedBox(width: 10),
                              Text(
                                '${resturantProfile!.address}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),

                      //Resturant Contact
                      InkWell(
                        onTap: () {
                          launch('tel:${resturantProfile!.mobile}');
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Icon(Icons.call_outlined, size: 14),
                              SizedBox(width: 10),
                              Text(
                                '${resturantProfile!.mobile}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),

                      //Resturant Delivery Charges
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.delivery_dining_rounded, size: 14),
                            SizedBox(width: 10),
                            Text(
                              'Delivery Charges ',
                              style:
                                  TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                            Text(
                              '${resturantProfile!.currencySymbol}${resturantProfile!.deliveryCharges}',
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      //Resturant Address
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.delivery_dining_outlined, size: 14),
                            SizedBox(width: 10),
                            Text(
                              'Free Delivery After ',
                              style:
                                  TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                            Text(
                              '${resturantProfile!.currencySymbol}${resturantProfile!.freeDeliveryAfter}',
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      //Resturant Rating
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.star_border_purple500_rounded, size: 14),
                            SizedBox(width: 10),
                            Text(
                              'Rating ',
                              style:
                                  TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.star_rate_outlined,
                                color: kPrimaryColor, size: 14),
                            Text(
                              '${resturantProfile!.rating}',
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      //Resturant Timing
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.timelapse_outlined, size: 14),
                            SizedBox(width: 10),
                            Text(
                              'Timings',
                              style:
                                  TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      for (var day in resturantProfile!.timingList!)
                        Padding(
                          padding: EdgeInsets.only(left: 45),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${day.dayName}'),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'From: ',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    Text('${day.from}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'To: ',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    Text('${day.to}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  resturantBanner() {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(200),
      decoration: BoxDecoration(color: kCardBackgroundColor),
      child: resturantProfile!.banner != null
          ? Image.network('${resturantProfile!.banner}', fit: BoxFit.cover)
          : Center(
              child:
                  Icon(Icons.image_outlined, size: 60, color: Colors.black38),
            ),
    );
  }

  backButton(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kWhiteColor,
            ))
      ],
    );
  }
}
