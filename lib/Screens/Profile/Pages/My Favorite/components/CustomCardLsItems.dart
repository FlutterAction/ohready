import 'package:flutter/material.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Menu%20List/Items%20List/ItemDetailScreens/ItemDetailScreen.dart';

import '../../../../../Components/constants.dart';

class CustomCardLsItems extends StatelessWidget {
  final dynamic data;
  CustomCardLsItems([this.data]);
  final TextStyle style = TextStyle(
    color: Colors.black54,
  );
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        ResturantProfileModel?  resturantProfile;
          APIManager().getResturantProfile(context, resturantId: data!.restaurantCode.toString()).then((value) {
          resturantProfile = value;
        Navigator.push(context, MaterialPageRoute(builder: (_)=> ItemDetails(item: data, resturantProfile: resturantProfile)));
        });
        
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
                  image: DecorationImage(image: NetworkImage(data!.image!)),
                  color: kCardBackgroundColor,
                  borderRadius: BorderRadius.circular(20)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                data!.name!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                data!.name!,
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
