import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Modals/Cart/Cartitem.dart';
import 'package:secure_hops/Modals/Favorites/favorites_model.dart';
import 'package:secure_hops/Modals/Item%20Details/ItemDetails.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/loading.dart';
import 'package:secure_hops/Widgets/navigator.dart';

class ItemDetails extends StatefulWidget {
  final dynamic item;
  final ResturantProfileModel? resturantProfile;
  ItemDetails({@required this.item, @required this.resturantProfile});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  ItemDetailsModel? itemDetails;
  int value = 1;
  bool variationsCheck = false;
  String variationValue = "";
  bool isLoading = true;

  //List
  List<Variations> variationList = [];
  List<List> cGList = [];
  List myCart = [];
  double? totalPrice = 0;
  int cGLength = 0;

  @override
  void initState() {
    getItemDetils();
    super.initState();
  }

  getPrice(List<Variations> variations) {
    if (variations.length == 1) {
      totalPrice = widget.item!.price;
    }
  }

  getItemDetils() {
    return APIManager()
        .getItemDetails(context, itemId: widget.item!.itemCode.toString())
        .then((_itemDetails) {
      //
      itemDetails = _itemDetails;

      // log(itemDetails.toString());

    //     if (itemDetails != null)
    //       // if(APIManager.allFavorites['lstItem'].isNotEmpty)
    //         APIManager.allFavorites['lstItem'].forEach((val) {
    //           if (itemDetails!.name == val!.name) {
    //             isAdded = true;
    //             print("MATCHED");
    //           } else {
    //             print("Comme Ome ");
    //           }
    //         });

    //   getPrice(itemDetails!.variations!);

    //   // get Cart minimun length
    //   itemDetails!.choiceGroups!.forEach((element) {
    //     cGLength = cGLength + element.minimum!;
    //   });

    //   //create List for checkBox
    //   itemDetails!.choiceGroups!.forEach((element) {
    //     cGList.add([]);
    //   });

    //   setState(() {
    //     isLoading = false;
    //   });
    });
  }

  void handlecheckBoxValueChanged(bool? value) {
    setState(() {
      variationsCheck = value!;
    });
  }

  box(double height) {
    return SizedBox(
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(APIManager.allFavorites['lstItem']);
          // print(itemDetails!.choiceGroups);
        },
      ),
      bottomNavigationBar:
          Consumer<MyProvider>(builder: (context, provider, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //item quantity
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: MyButton(
                    text:
                        "Add To Cart :  ${convertPrice(context, totalPrice!)}",
                    onPressed: () {
                      checkCartConditions(provider);
                    }),
              ),
            ),
            Expanded(
              child: itemCount(),
            ),
          ],
        );
      }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // item image
              itemImages(),

              box(20),

              //item name and price
              itemName(),
              box(20),

              //item description
              itemDescription(),
              box(10),

              box(5),
              Divider(),
              box(5),

              //item variations list
              if (isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                itemDetails!.variations!.length > 1
                    ? variations()
                    : Container(),

              //item choice group list
              if (isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                for (int index = 0;
                    index <= itemDetails!.choiceGroups!.length - 1;
                    index++)
                  choiceGroupsList(itemDetails!.choiceGroups![index], index),
            ],
          ),
        ),
      ),
    );
  }

  itemName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "${widget.item!.name}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Text(
            convertPrice(context, widget.item!.price!),
            style: TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  itemDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "${widget.item!.highLights}",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    );
  }

  itemImages() {
    return Stack(children: [
      Card(
        child: Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.item!.image!), fit: BoxFit.cover),
            )),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
          customPOP(context),
            Spacer(),
            // Adding and Removing Favorites
            IconButton(
              onPressed: () {
                  MyProvider provider = Provider.of<MyProvider>(context, listen: false);
                if (provider.loginResponse != null) {
                addOrDeleteFavorites();
                } else {
                  snackBarAlert("Please! Login First");
                }
                // print("Added");
                

                // print(res);
              },
              icon: Icon(isAdded ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,),
              color: kWhiteColor,
            )
          ],
        ),
      ),
    ]);
  }

  
  /// Adding Favorites
  bool isAdded = false;

  addOrDeleteFavorites() {
    if (isAdded) {
      removeFavoritesItem();
      snackBarAlert("Removed into Favorites");
      setState(() {
        isAdded = false;
      });
    } else {
      addFavoritesItem();
      snackBarAlert("Added into Favorites");
      setState(() {
        isAdded = true;
      });
    }
  }

  snackBarAlert(text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 300),
    ));
  }

  addFavoritesItem() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);

    APIManager()
        .addFavorites(context,
            email: provider.loginResponse!.user!.email,
            password: provider.loginResponse!.password,
            itemCode: widget.item!.itemCode)
        .then((value) {
      getFavoritesItems();
    });
  }

  removeFavoritesItem() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);

    APIManager()
        .removeFavorites(context,
            email: provider.loginResponse!.user!.email,
            password: provider.loginResponse!.password,
            itemCode: widget.item!.itemCode)
        .then((value) {
      getFavoritesItems();
    });
  }




  getFavoritesItems() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    APIManager()
        .getFavoritesItems(context,
            email: provider.loginResponse!.user!.email,
            password: provider.loginResponse!.password)
        .then((response) {
     List<LstRestaurant>? lstRestaurant = response.lstRestaurant;
     List<LstItem>? lstItem = response.lstItem;


      setState(() {
      APIManager.allFavorites['lstRestaurant'] = lstRestaurant;
      APIManager.allFavorites['lstItem'] = lstItem;
      });
    });
  }

  itemCount() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            "Quantity",
            style: TextStyle(
              // fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Container(
            height: 35,
            decoration: BoxDecoration(
                color: Color(0xFFEEF3FC),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (value > 0) {
                          value--;
                        }
                      });
                    },
                    icon: FaIcon(FontAwesomeIcons.minus, size: 10)),
                Text('$value'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        value++;
                      });
                    },
                    icon: FaIcon(Icons.add, size: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  variations() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Select Variations",
                style: customStyle,
              ),
              Spacer(),
              Text(
                "1 Required",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (isLoading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            for (var variation in itemDetails!.variations!)
               Container(
                 color: isEmptyvariation? Colors.red[200]: Colors.white,
                 margin: EdgeInsets.only(top: 2),
                 child: CheckboxListTile(                                 
                  value: variationList.contains(variation),
                  onChanged: (bool? value) {
                    setState(() {
                      isEmptyvariation = false;
                      if (value!) {
                        
                        print(variationList.contains(variation));
                        print(variationList.length);
                        // print(variation);
                        // print(value);
                         if (variationList.length == 0) {
                           print("length if less than 1");
                        //   //change price
                           totalPrice = totalPrice! + variation.price!;

                        //   //select variation
                          variationList.add(variation);
                        }
                        else{
                          // print(variationList.contains(variation));
                          variationList.forEach((element) {
                            if(element == variation){
                              
                        //   //change price
                           totalPrice = totalPrice! + variation.price!;

                        //   //select variation
                          variationList.add(variation);
                            }else{
                              totalPrice = totalPrice! - element.price!;
                          variationList.remove(element);
                            }
                          });
                          // totalPrice = totalPrice! - variation.price!;
                          // variationList.remove(variation);
                        }
                      } else {
                        print("in else");
                        // print(variationList.contains(variation));

                        // change price
                        totalPrice = totalPrice! - variation.price!;

                        // //unselect variation
                        variationList.remove(variation);
                      }
                    });
                  },
                  activeColor: kPrimaryColor,
                  title: Text(
                    '${variation.name}',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  // secondary: Text(convertPrice(context, variation.price!),),
                  secondary: variation.isOnDiscount! ?  Container(
                    width: 100,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          color: Colors.red[600],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Text("${variation.discountedPercentage!.round()} % Off",style:TextStyle(color: Colors.white,fontSize: 12)),),


                          Container(
                            // color: Colors.red,
                            // alignment: Alignment.centerRight,
                            // width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(convertPrice(context, variation.price) ,style: TextStyle(decoration: TextDecoration.lineThrough ,color: Colors.grey,fontWeight: FontWeight.bold),),
                            SizedBox(
                              width: 2,
                            ),
                                  Text(convertPrice(context,variation.discountedPrice),style:TextStyle(
                                    fontWeight: FontWeight.bold
                                  )),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ) : Text(convertPrice(context,variation.price),style: TextStyle(fontWeight: FontWeight.bold),),
                  controlAffinity: ListTileControlAffinity.leading,
              ),
               ),
        ],
      ),
    );
  }

  choiceGroupsList(ChoiceGroups choiceGroup, index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        
        children: [
          Row(
            children: [
              Text(
                "${choiceGroup.groupName}",
                style: customStyle,
              ),
              Spacer(),
              Text(
                choiceGroup.minimum == 0
                    ? "Optional"
                    : "${choiceGroup.minimum} Required",
                style: TextStyle(
                  color:
                      choiceGroup.minimum == 0 ? Colors.black38 : kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 25),

            alignment: Alignment.centerLeft,
            child: choiceGroup.minimum == 0 ? Text("Select Maximum ${choiceGroup.maximum} (Optional)",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold))  : choiceGroup.minimum == choiceGroup.maximum ? Text("Select ${choiceGroup.minimum}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)) : Text("Select ${choiceGroup.minimum} ( Maximum ${choiceGroup.maximum} )",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
          for (var option in choiceGroup.options!)
            CheckboxListTile(
              value: cGList[index].contains(option.optionCode),
              onChanged: (bool? value) {
                setState(() {
                  if (value!) {
                    
                    if (cGList[index].length < choiceGroup.maximum!) {
                      //change price
                      totalPrice = totalPrice! + option.price!;

                      //add option to cart
                      myCart.add(option);

                      //select option
                      cGList[index].add(option.optionCode);
                    }
                  } else {
                    //change price
                    totalPrice = totalPrice! - option.price!;

                    //remove option from cart
                    myCart.remove(option);

                    //unselect option
                    cGList[index].remove(option.optionCode);
                  }
                });
              },
              activeColor: kPrimaryColor,
              title: Text(
                '${option.name}',
                style: new TextStyle(fontSize: 16.0),
              ),
              secondary: Text(convertPrice(context, option.price!)),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            
        ],
      ),
    );
  }


  bool isEmptyvariation = false;
  checkCartConditions(MyProvider provider) {
    //if product has no choice group
    if (itemDetails!.choiceGroups!.length == 0) {
      //
      if (itemDetails!.variations!.length > 1 && variationList.length < 1) {
        print(2);
        setState(() {
          isEmptyvariation = true;
          print("Empty");
        });
        // showErrorDialog(context, 'Choose Variration${variationList.length}');
      }

      //
      else {
        addToCart(provider);
      }
    }

    //if the product has a choice group
    else {
      var isTrue = false;

      //
      var choiceGroupsList = itemDetails!.choiceGroups!
          .where((choiceGroups) => choiceGroups.minimum! > 0)
          .toList();

      choiceGroupsList.forEach((choiceGroup) {
        print(choiceGroup.options);
        print("----------------------");
        print(myCart.length);
        print(provider.myCart);
        isTrue = choiceGroup.options!
            .any((choiceOptions) => myCart.contains(choiceOptions));

        if (isTrue == false) {
          print(1);
          // showErrorDialog(context, 'Choose Required Fields $choiceOptions');
        }

        
        else if (itemDetails!.variations!.length > 1 &&
            variationList.length < 1) {
          print(2);
          // showErrorDialog(context, 'Choose Variration${variationList.length}');
        }

        
        else {
          addToCart(provider);
        }
      });
    }
  }

  addToCart(MyProvider provider) {
    // if there is only one variation then add it to cart
    if (itemDetails!.variations!.length == 1) {
      variationList.add(itemDetails!.variations!.first);
    }

    //cartitem model
    CartItem cartItem = CartItem.fromJson({
      "item": itemDetails!.toJson(),
      "options": myCart,
      "variations": variationList.first
    });

    //
    print(3);

    //save resturant profile in provider to use on Cart page
    provider.saveResturantProfile(widget.resturantProfile!);

    //save cartList in provider to use on Cart page
    // provider.saveMyCart(
    //     cartItem: cartItem, resturantProfilee: widget.resturantProfile!);
    CustomSnackBar.show(context, 'Addedd Successfully.');
    pop(context);
  }
}
