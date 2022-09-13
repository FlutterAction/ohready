import 'package:flutter/material.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Card/Resturant%20Card.dart';
import 'package:secure_hops/Screens/Profile/Pages/My%20Favorite/components/CustomCardLsRestaurant.dart';

class Resturants extends StatefulWidget {
  final lstRestaurant;
  Resturants(this.lstRestaurant);
  @override
  _ResturantsState createState() => _ResturantsState();
}

class _ResturantsState extends State<Resturants> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20,left: 10,right: 10 ),
      child:   GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,              
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               childAspectRatio: 0.7,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,  
              ),
              itemCount: widget.lstRestaurant.length,              
              itemBuilder: (context, index) {
                return ResturantCard(resturant:widget.lstRestaurant[index]);
              },
            )
    );
  }
}
