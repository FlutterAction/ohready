import 'package:flutter/material.dart';
import 'package:secure_hops/Screens/Profile/Pages/My%20Favorite/components/CustomCardLsItems.dart';
import 'package:secure_hops/Screens/Profile/Pages/My%20Favorite/components/CustomCardLsRestaurant.dart';

class Food extends StatefulWidget {
  final dynamic lstItem;
  Food(this.lstItem);
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: 
      
      GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                childAspectRatio: 0.6,
                mainAxisSpacing: 5.0,      
              ),
              itemCount: widget.lstItem.length,              
              itemBuilder: (context, index) {
                return CustomCardLsItems(widget.lstItem[index]);
              },
            )
      
      // ListView.builder(
      //   itemCount: widget.lstItem.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return CustomCardLsItems(widget.lstItem[index]);
      //   },
      // ),
    );
  }
}
