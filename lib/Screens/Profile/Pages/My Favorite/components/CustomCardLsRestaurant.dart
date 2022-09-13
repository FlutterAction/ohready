import 'package:flutter/material.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Profile.dart';
import 'package:secure_hops/Screens/Profile/Pages/My%20Favorite/Tabs/Resturants.dart';

import '../../../../../Components/constants.dart';

class CustomCardLsRestaurant extends StatelessWidget {

  final  data;
  CustomCardLsRestaurant([this.data]);
  final TextStyle style = TextStyle(
    color: Colors.black54,
  );
  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>  ResturantProfile(resturantId: data.restaurantCode,) ));        
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: 90,
              height: 150,
              //  child: Image.network(data.image,fit: BoxFit.fill),
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(data.bannerImage),fit: BoxFit.fill),
                  color: kCardBackgroundColor,
                  borderRadius: BorderRadius.circular(20)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                data.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                data.foodTypes,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
    
  
  }
}
