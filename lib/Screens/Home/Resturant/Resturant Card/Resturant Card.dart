import 'package:flutter/material.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Resturants/Search%20Resturant.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Profile.dart';
import 'package:secure_hops/Widgets/navigator.dart';

class ResturantCard extends StatelessWidget {
  final  resturant;
  const ResturantCard({@required this.resturant});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      color: Colors.black54,
    );
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      child: InkWell(
          onTap: () {
            rootPush(
                context,
                ResturantProfile(
                  resturantId: resturant!.restaurantCode,
                ));
            // print(resturant!.restaurantCode);
          },
          child: Container(
            decoration: BoxDecoration(
                color: kWhiteColor
                // color: Colors.red
                , borderRadius: BorderRadius.circular(10)),
            // height: 500,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        child: Image.network(
                          resturant!.bannerImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 35,
                          decoration: BoxDecoration(color: kWhiteColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, size: 14, color: kPrimaryColor),
                              SizedBox(width: 3),
                              Text(
                                '${resturant!.rating}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               
               
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(resturant!.name!,
                      maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(
                        resturant!.foodTypes.toString(),
                        maxLines: 2,
                        style: TextStyle(
                          
                          overflow: TextOverflow.ellipsis,
                            color: textColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 10,
                            ),
                            Text('0.2 Km -\$\$', style: style),
                            Spacer(),
                            Icon(
                              Icons.delivery_dining_outlined,
                              size: 10,
                              color: primaryColor,
                            ),
                            Text('Free', style: TextStyle(color: primaryColor)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
