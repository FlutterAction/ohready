import 'package:flutter/material.dart';
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'ItemDetailScreens/itemTest.dart';

class ItemCard extends StatelessWidget {
  final int? cartItems;
  final Item? item;
  final ResturantProfileModel? resturantProfile;
  const ItemCard({@required this.item, @required this.resturantProfile, this.cartItems});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      color: Colors.black54,
    );
    return InkWell(
      onTap: () {
        
        push(
            context,
            ItemTest(
              item: item,
              resturantProfile: resturantProfile,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Stack(
          overflow: Overflow.clip,
          clipBehavior : Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Image
                  Container(
                    width: double.infinity,
                    // height: getProportionateScreenHeight(125),
                    decoration: BoxDecoration(
                        color: kCardBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: item!.image != null
                          ? AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      item!.image!,
                                    ),
                                    //whatever image you can put here
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 200,
                              color: Colors.grey[200],
                              child: Image.asset("assets/logo.png"),
                            ),
                      // Image.network('$domain${item!.image}', fit: BoxFit.cover),
                    ),
                  ),

                  // Empty Box
                  SizedBox(
                    height: 10,
                  ),

                  //item name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(item!.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),

                  //empty box
                  SizedBox(
                    height: 10,
                  ),

                  //price
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${convertPrice(context, item!.price!)}",
                            style: style),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.star,
                            size: 18,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text('${item!.rating}',
                                style: TextStyle(color: primaryColor)),
                            Text("(${item!.totalRating})"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
         cartItems == 0 ? Container(height: 0,width: 0,) :    Positioned(
              right: -5,
              top: -5,
                child: Container(
                  height: 20,
                  width: 20,
              decoration: BoxDecoration(
                  color: primaryColor,
                borderRadius: BorderRadius.circular(100),
                // border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  "$cartItems",
                  style: TextStyle(color: Colors.white,fontSize: 12, ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
