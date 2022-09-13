import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Cart/addToCartModel.dart' as cartModel;

import 'package:secure_hops/Modals/Cart/cartModels.dart';
import 'package:secure_hops/Modals/Favorites/favorites_model.dart';
import 'package:secure_hops/Modals/Item%20Details/ItemDetails.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/SnackBar.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/loading.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemTest extends StatefulWidget {
  final dynamic item;
  final ResturantProfileModel? resturantProfile;
  cartModel.LstItem? cartItem;
  // ItemTest([this.cartItem]);
  ItemTest(
      {@required this.item, @required this.resturantProfile, this.cartItem});

  @override
  _ItemTestState createState() => _ItemTestState();
}

class _ItemTestState extends State<ItemTest> {
  ItemDetailsModel? itemDetails;
  int value = 1;

  bool variationsCheck = false;
  String variationValue = "";
  bool isLoading = true;

  //List
  List<Variations> variationList = [];
  List cGList = [];
  List myCart = [];
  double? totalPrice = 0;
  int cGLength = 0;
  double? variationPrice = 0;

  bool isComplete = false;

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
    setState(() {
      isComplete = true;
    });
    return APIManager()
        .getItemDetails(context, itemId: widget.item!.itemCode.toString())
        .then((_itemDetails) {
      itemDetails = _itemDetails;

      itemDetails!.choiceGroups!.forEach((element) {
        cGList.add({"${element.groupName}": []});
      });
      if (widget.cartItem != null)
        for (var cGListItems in cGList) {
          var cGListItemsKey = cGListItems.keys.toList()[0];
          for (var cartitem in widget.cartItem!.lstChoiceGroups!) {
            if (cGListItemsKey == cartitem.groupName) {
              var options = [];
              for (var myItem in cartitem.lstOptions!) {
                options.add(ChoiceOptions.fromJson({
                  'groupCode': myItem.groupCode,
                  'optionCode': myItem.optionCode,
                  'optionName': myItem.optionName,
                  'price':
                      myItem.price != null ? myItem.price.toDouble() : null,
                  'discountedPrice': myItem.discountedPrice != null
                      ? myItem.discountedPrice
                      : null,
                  'discountFromDate': myItem.discountFromDate,
                  'discountToDate': myItem.discountToDate,
                }));

                // options.add(ChoiceOptions.fromJson(myItem.toJson() as dynamic));
                print(myItem.toJson());
              }
              for (ChoiceOptions myOptions in options) {
                totalPrice = totalPrice! + myOptions.price!;
                cGListItems[cGListItemsKey].add(myOptions);
              }
              variationPrice = widget.cartItem!.price;
              variationCode = widget.cartItem!.selectedVariationCode;
              // variationList.add(widget.cartItem!.selectedVariationName);

            }
          }
        }

      print(cGList);
      setState(() {
        isComplete = false;
      });

      // setState(() {});
    });
  }

  var variationCode;

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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        SavedSharePreference().addToCart(null);

        SavedSharePreference().setResturantName(
            widget.resturantProfile!.restaurantCode.toString());
        Navigator.pop(context);
        MyProvider provider = Provider.of<MyProvider>(context, listen: false);
        checkCartConditions(provider);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Ready to Delete?",
        style: TextStyle(color: kPrimaryColor),
      ),
      content: Text("This Action will Delete Your Previous Cart?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  alreadyExist(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("OK"),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Already Exist in Cart",
        style: TextStyle(color: kPrimaryColor),
      ),
      content: Text("This Action will Delete Your Previous Cart?"),
      actions: [
        // cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // print(widget.cartItem!.selectedVariationCode);
          SavedSharePreference().clearShareprefrence();
          print("Success");
          print(await SavedSharePreference().getAddToCart());
        },
      ),
      bottomNavigationBar:
          Consumer<MyProvider>(builder: (context, provider, child) {
        return Container(
          color: Colors.red[100],
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //item quantity
              Expanded(
                child: MyButton(
                    text:
                        "Add To Cart :  ${convertPrice(context, totalPrice! + variationPrice!)}",
                    onPressed: () async {
                      var resturantName =
                          await SavedSharePreference().getResturantName()!;

                      if (resturantName == null) {
                        SavedSharePreference().setResturantName(
                            widget.resturantProfile!.restaurantCode.toString());
                        // SavedSharePreference().
                        checkCartConditions(provider);
                      } else {
                        if (resturantName !=
                            widget.resturantProfile!.restaurantCode.toString())
                          showAlertDialog(context);
                        else
                          checkCartConditions(provider);
                      }
                    }),
              ),
              Expanded(
                child: itemCount(),
              ),
            ],
          ),
        );
      }),
      body: SafeArea(
        child: itemDetails == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    leading: customPOP(context),
                    actions: [
                      IconButton(
                        onPressed: () {
                          MyProvider provider =
                              Provider.of<MyProvider>(context, listen: false);
                          if (provider.loginResponse != null) {
                            addOrDeleteFavorites();
                          } else {
                            snackBarAlert(context, "Please! Login First");
                          }
                          // print("Added");

                          // print(res);
                        },
                        icon: Icon(
                          isAdded
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                        ),
                        color: kWhiteColor,
                      )
                    ],
                    expandedHeight: SizeConfig.screenHeight! * .35,
                    backgroundColor: Colors.white,
                    flexibleSpace: _MyAppSpace(widget.item),
                    // FlexibleSpaceBar(
                    //   // title: Text("Arham"),
                    //   background: Container(
                    //       height: SizeConfig.screenHeight! * .45,
                    //       decoration: BoxDecoration(
                    //         image: DecorationImage(
                    //             image: NetworkImage(widget.item!.image!),
                    //             fit: BoxFit.cover),
                    //       )),
                    // )
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        return isComplete
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // item image
                                  // itemImages(),

                                  // box(20),
                                  box(10),
                                  //item name and price
                                  itemName(),
                                  box(5),

                                  //item description
                                  // itemDescription(),
                                  box(5),

                                  box(5),
                                  Divider(),
                                  box(5),

                                  //item variations list
                                  // if (isLoading)
                                  //   Padding(
                                  //     padding: EdgeInsets.symmetric(vertical: 20),
                                  //     child: Center(
                                  //       child: CircularProgressIndicator(),
                                  //     ),
                                  //   )
                                  // else

                                  if (itemDetails != null)
                                    itemDetails!.variations!.isNotEmpty
                                        ? variations()
                                        : Container(),

                                  //item choice group list
                                  // if (isLoading)
                                  //   Padding(
                                  //     padding: EdgeInsets.symmetric(vertical: 20),
                                  //     child: Center(
                                  //       child: CircularProgressIndicator(),
                                  //     ),
                                  //   )
                                  // else
                                  for (int index = 0;
                                      index < itemDetails!.choiceGroups!.length;
                                      index++)
                                    choiceGroupsList(
                                        itemDetails!.choiceGroups![index],
                                        index),
                                ],
                              );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
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
          fontSize: 15,
          color: Colors.grey[600],
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
                MyProvider provider =
                    Provider.of<MyProvider>(context, listen: false);
                if (provider.loginResponse != null) {
                  addOrDeleteFavorites();
                } else {
                  snackBarAlert(context, "Please! Login First");
                }
                // print("Added");

                // print(res);
              },
              icon: Icon(
                isAdded ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              ),
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
      snackBarAlert(context, "Removed into Favorites");
      setState(() {
        isAdded = false;
      });
    } else {
      addFavoritesItem();
      snackBarAlert(context, "Added into Favorites");
      setState(() {
        isAdded = true;
      });
    }
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
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Quantity",
            style: TextStyle(
              // fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.20,
            margin: EdgeInsets.only(left: 5),
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: Color(0xFFEEF3FC),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (value > 1) {
                        value--;
                      }
                    });
                  },
                  child: FaIcon(FontAwesomeIcons.minus, size: 10),
                ),
                Text('$value'),
                InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    setState(() {
                      value++;
                    });
                  },
                  child: FaIcon(FontAwesomeIcons.plus, size: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Variation
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
          for (var variation in itemDetails!.variations!)
            Container(
              margin: EdgeInsets.only(bottom: 2),
              color: isEmptyvariation ? Colors.red[100] : Colors.transparent,
              // width: MediaQuery.of(context).size.width,
              child: Theme(
                data: ThemeData(
                    unselectedWidgetColor: kPrimaryColor,
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    )),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("${variation.name}"),
                  value: (variationCode != null)
                      ? variationCode == variation.variationCode
                          ? true
                          : variationList.contains(variation)
                      : variationList.contains(variation),
                  onChanged: (val) {
                    isEmptyvariation = false;

                    if (variationList.contains(variation)) {
                      variationList.clear();
                      if (variationCode != null)
                        variationCode = variation.variationCode;
                      variationPrice = 0;
                    } else {
                      if (variationList.length == 1) {
                        variationList.clear();
                        if (variationCode != null)
                          variationCode = variation.variationCode;
                        variationPrice = 0;
                        variationList.add(variation);
                        variationPrice = variation.price!;
                      } else {
                        variationList.add(variation);
                        if (variationCode != null)
                          variationCode = variation.variationCode;
                        variationPrice = variation.price!;
                      }
                    }
                    setState(() {});
                  },
                  secondary: variation.isOnDiscount!
                      ? Container(
                          // width: 100,
                          // color: Colors.red,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red[600],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                    "${variation.discountedPercentage!.round()} % Off",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                              Container(
                                // alignment: Alignment.centerRight,
                                // width: 100,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      convertPrice(context, variation.price),
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                        convertPrice(
                                            context, variation.discountedPrice),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          convertPrice(context, variation.price),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  activeColor: kPrimaryColor,
                ),
              ),
            )
        ],
      ),
    );
  }

  checkContains(index, choiceGroup, option) {
    bool check = cGList[index][choiceGroup.groupName].contains(option);

    print("ARHAM $check ${cGList[1]["Make it a Combo."].contains(option)}");
    print(option.name);
    // print(cGList);
    return check;
  }

  // Choices Group
  choiceGroupsList(ChoiceGroups? choiceGroup, index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "${choiceGroup!.groupName}",
              style: customStyle,
            ),
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  child: choiceGroup.minimum == 0
                      ? Text("Select Maximum ${choiceGroup.maximum} (Optional)",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold))
                      : choiceGroup.minimum == choiceGroup.maximum
                          ? Text("Select ${choiceGroup.minimum}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold))
                          : Text(
                              "Select ${choiceGroup.minimum} ( Maximum ${choiceGroup.maximum} )",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )),
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
          for (var option in choiceGroup.options!)
            Container(
              margin: EdgeInsets.only(bottom: 2),
              color: !isCheckStart
                  ? Colors.transparent
                  : cGList[index]["${choiceGroup.groupName}"].contains(option)
                      ? Colors.transparent
                      : choiceGroup.minimum! >
                              cGList[index]["${choiceGroup.groupName}"].length
                          ? Colors.red[100]
                          : Colors.transparent,
              child: Theme(
                data: ThemeData(
                    unselectedWidgetColor: kPrimaryColor,
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    )),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  // value: cGList[index].contains(option.optionCode),
                  // value: checkContains(index,choiceGroup,option),
                  value: cGList[index][choiceGroup.groupName]
                      .any((i) => i.optionCode == option.optionCode),
                  // value: true,
                  onChanged: (bool? value) {
                    cGList[index]["${choiceGroup.groupName}"].forEach((val){
                      print(val.name);
                    });                    
                    // print(cGList[index]["${choiceGroup.groupName}"]);
                    // print(option);

                    // print(cGList[index]["${choiceGroup.groupName}"].runtimeType);
                    // print(option.runtimeType);
                    // print(cGList[index]["${choiceGroup.groupName}"]);
                    // print(option.toJson());
                    if (cGList[index][choiceGroup.groupName]
                      .any((i) => i.optionCode == option.optionCode)) {
                          print("contain");
                      cGList[index]["${choiceGroup.groupName}"].remove(option);
                      //change price
                      totalPrice = totalPrice! - option.price!;
                    } else {
                      if (cGList[index]["${choiceGroup.groupName}"].length <
                          choiceGroup.maximum) {
                        //     //change price
                        totalPrice = totalPrice! + option.price!;
                        cGList[index]["${choiceGroup.groupName}"].add(option);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${choiceGroup.maximum} Max are Selected"),
                          duration: Duration(milliseconds: 600),
                        ));
                      }
                    }

                    // print(cGList[index]["${choiceGroup.groupName}"]);

                    setState(() {
                      // if (value!) {

                      //   if (cGList[index].length <= choiceGroup.maximum!) {
                      //     //change price
                      //     totalPrice = totalPrice! + option.price!;

                      //     //add option to cart
                      //     // myCart.add(option);

                      //     //select option
                      //     // cGList[index].add(option.optionCode);
                      //   }
                      // } else {
                      //   //change price
                      //   totalPrice = totalPrice! - option.price!;

                      //   //remove option from cart
                      //   // myCart.remove(option);

                      //   //unselect option
                      //   // cGList[index].remove(option.optionCode);
                      // }
                    });
                  },
                  activeColor: kPrimaryColor,

                  selectedTileColor: kPrimaryColor,

                  title: Text(
                    '${option.name}',
                    style: new TextStyle(fontSize: 14.0),
                  ),
                  secondary:
                      //  (option.discountedPrice != null) || (option.discountedPrice != 0)
                      //     ? Container(
                      //         // width: 100,
                      //         // color: Colors.red,
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           crossAxisAlignment: CrossAxisAlignment.end,
                      //           children: [
                      //             Container(
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(5),
                      //                 color: Colors.red[600],
                      //               ),
                      //               padding: EdgeInsets.symmetric(
                      //                   horizontal: 10, vertical: 5),
                      //               child: Text(
                      //                   "${option.discountedPrice} % Off",
                      //                   style: TextStyle(
                      //                       color: Colors.white, fontSize: 12)),
                      //             ),
                      //             Container(
                      //               // alignment: Alignment.centerRight,
                      //               // width: 100,
                      //               child: Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 mainAxisAlignment: MainAxisAlignment.end,
                      //                 children: [
                      //                   Text(
                      //                     convertPrice(context, option!.price),
                      //                     style: TextStyle(
                      //                         decoration:
                      //                             TextDecoration.lineThrough,
                      //                         color: Colors.grey,
                      //                         fontWeight: FontWeight.bold),
                      //                   ),
                      //                   SizedBox(
                      //                     width: 2,
                      //                   ),
                      //                   Text(
                      //                       convertPrice(
                      //                           context, option.discountedPrice),
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     :
                      Text(
                    convertPrice(context, option.price),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool isCheckStart = false;
  bool isEmptyvariation = false;
  var missingSelection = [];
  List listOptions = [];
  var listGroupChoices = [];
  checkCartConditions(MyProvider provider) {
    missingSelection.clear();
    listGroupChoices.clear();

    if (variationList.isEmpty) {
      // print(2);

      if (itemDetails!.variations!.isNotEmpty) {
        if (widget.cartItem != null) {
          isEmptyvariation = false;
        } else {
          setState(() {
            isEmptyvariation = true;
          });
          missingSelection.add("Variations");
        }
      }
      // showErrorDialog(context, missingSelection);
    }
    if (cGList.isNotEmpty) {
      setState(() {
        isCheckStart = true;
      });
      if (itemDetails!.choiceGroups!.isNotEmpty)
        itemDetails!.choiceGroups!.forEach((element) {
          // print(element.groupName);
          for (var item in cGList) {
            // listOptions.clear();
            var key = item.keys.toList()[0];
            if (element.groupName == key) {
              // print("${item[key].length}   ${element.minimum}");
              // print(listOptions);
              if (item[key].length < element.minimum) {
                // print(item[key]);
                // print("${element.groupName} No SatisFied");
                missingSelection.add(element.groupName);
              } else {
                // print(element.groupName);

                print(listOptions);
              }
              if (missingSelection.isEmpty) if (item[key].isNotEmpty) {
                manageAddToCart(context, item[key], element);
              }
            }
          }
        });
    }

    showErrorDialog(
        context, missingSelection, widget.resturantProfile!.restaurantCode!);
    if (missingSelection.isEmpty) {
      addToCart();
    }
    setState(() {});
  }

  List<mdlCartChoiceGroup> choiceGroupList = [];

  manageAddToCart(context, selectedItems, groupDetails) {
    List<mdlChoiceGroupOption> selectedOptionsList = [];
    if (selectedItems.isNotEmpty) {
      selectedItems.forEach((item) {
        var myOption = mdlChoiceGroupOption.fromJson(item.toJson());
        selectedOptionsList.add(myOption);
      });
      var choiceGroup = mdlCartChoiceGroup.fromJson({
        "groupCode": groupDetails.groupCode,
        "groupName": groupDetails.groupName,
        "lstOptions": selectedOptionsList,
      });

      choiceGroupList.add(choiceGroup);
      print(choiceGroupList.length);
      // provider.saveMyCart(cartItem: cartItem, resturantProfilee: resturantProfilee)
    }
  }

  mdlCart? cart;
  addToCart() async {
    var itemMatched;
    // List lstItems = [];

    bool isFound = false;
    // print("IN MY CART : ${choiceGroupList.length}");

    var cartItem = mdlCartItem.fromJson({
      "indx": 1,
      "restaurantCode": itemDetails!.restaurantCode,
      "branchCode": itemDetails!.branchCode,
      "itemCode": itemDetails!.itemCode,
      "itemName": itemDetails!.name,
      "itemImage": itemDetails!.image,
      "whatToDo": "Yes", // No IDEA
      "instructions": "no One", // NO IDEA
      "selectedVariationCode": variationList.isEmpty
          ? widget.cartItem!.selectedVariationCode
          : variationList.first.variationCode,
      "selectedVariationName": variationList.isEmpty
          ? widget.cartItem!.selectedVariationName
          : variationList.first.name,
      "isOneVariation": true,
      "price": variationList.isEmpty
          ? widget.cartItem!.price
          : variationList.first.price,
      "discountedPrice": variationList.isEmpty
          ? widget.cartItem!.discountedPrice
          : variationList.first.discountedPrice,
      "qnty": value,
      "rowTotal": totalPrice! + variationPrice!,
      "lstChoiceGroups": choiceGroupList,
    });

    // Fetching Cart
    var cartData = await SavedSharePreference().getAddToCart();

    // Checking Card Null or not
    if (cartData == null) {
      cart = mdlCart.fromJson({
        "restaurantCode": widget.resturantProfile!.restaurantCode,
        "lstItems": [],
        "subTotal": 0,
        "saleTaxPer": 0,
        "saleTax": 0,
        "shippingCharges": widget.resturantProfile!.deliveryCharges,
        "discount": 0,
        "voucherCode": widget.resturantProfile!.currencySymbolHtmlCode,
        "voucherName": "",
        "currencySymbol": widget.resturantProfile!.currencySymbol,
        "currencySymbolHtmlCode":
            widget.resturantProfile!.currencySymbolHtmlCode,
        "total": 0,
      });
      cart!.lstItems!.add(cartItem);
      cart!.total += totalPrice! + variationPrice!;
      SavedSharePreference().updateToCart(cart);
    } else {
      // Selected Items String
      String newString =
          "itemCode:${itemDetails!.itemCode},variationCode:${variationList.isEmpty ? variationCode : variationList.first.variationCode},";
      if (choiceGroupList.isNotEmpty) {
        choiceGroupList.forEach((cg) {
          newString = newString + "${cg.groupName}:";
          if (cg.lstSelectedOptions!.isNotEmpty) {
            cg.lstSelectedOptions!.forEach((op) {
              newString = newString + "${op.optionName},";
            });
          }
        });
      }
      //  -------------------------------------  //

      String? selectedCartString;

        selectedCartString =
            "itemCode:${widget.cartItem!.itemCode},variationCode:${widget.cartItem!.selectedVariationCode},";
        if (widget.cartItem!.lstChoiceGroups!.isNotEmpty) {
          widget.cartItem!.lstChoiceGroups!.forEach((cg) {
            selectedCartString = selectedCartString! + "${cg.groupName}:";
            if (cg.lstOptions!.isNotEmpty) {
              cg.lstOptions!.forEach((op) {
                selectedCartString = selectedCartString! + "${op.optionName},";
              });
            }
          });
        }
      //  Checking CartItems
    

        // -------------------------------------------  //

        ///     Matching CartItem and Selected Item
     
         
          if (cartData != null) {
            for (var item in cartData['lstItems']) {
              String cartString =
                  "itemCode:${item['itemCode']},variationCode:${item['selectedVariationCode']},";
              if (item['lstChoiceGroups'].isNotEmpty) {
                for (var cg in item['lstChoiceGroups']) {
                  cartString = cartString + "${cg['groupName']}:";
                  if (cg['lstOptions'].isNotEmpty) {
                    cg['lstOptions'].forEach((op) {
                      cartString = cartString + "${op['optionName']},";
                    });
                  }
                }
              }
              if (cartString == newString) {
                print("Matched");
                isFound = true;
                item['qnty'] = item['qnty'] + value;
                item['rowTotal'] = item['price'] * item['qnty'];
                cartData['total'] += totalPrice! + variationPrice!;
                // SavedSharePreference().updateToCart(cartData);
                break;
              } 
               else {
                print("No Match");
                isFound = false;
              }
              print("CART STRING $cartString");
            }
          }
        

        // cart!.lstItems!.add(cartItem);
        // SavedSharePreference().updateToCart(cart);
        // cartData['lstItems'].add(itemMatched);

        // for (var item in cartData['lstItems'])
        // if(itemMatched == item)
        //  item =  cartItem;

        if (isFound) {
          SavedSharePreference().updateToCart(cartData);
          // print(cartData[0]);
        } else {
          if(widget.cartItem == null){
          cartData['lstItems'].add(cartItem);
          cartData['total'] += totalPrice! + variationPrice!;
          SavedSharePreference().updateToCart(cartData);
          }
          else{
            for (var i=0 ; i< cartData['lstItems'].length ; i++) {
              String cartString2 =
                  "itemCode:${cartData['lstItems'][i]['itemCode']},variationCode:${cartData['lstItems'][i]['selectedVariationCode']},";
              if (cartData['lstItems'][i]['lstChoiceGroups'].isNotEmpty) {
                for (var cg in cartData['lstItems'][i]['lstChoiceGroups']) {
                  cartString2 = cartString2 + "${cg['groupName']}:";
                  if (cg['lstOptions'].isNotEmpty) {
                    cg['lstOptions'].forEach((op) {
                      cartString2 = cartString2 + "${op['optionName']},";
                    });
                  }
                }
                }
                print("cartString2 $cartString2");
                print("selectedCartString $selectedCartString");
                if (selectedCartString == cartString2) {
                  print("yessssssssssssssssssssssssssssssssssssssssssss");
                  cartData['lstItems'][i] = cartItem;
                  // mdlCartItem myTest = cartData['lstItems'][i];/
                  
                  // myTest.lstChoiceGroups!.forEach((element) { 
                  //   element.lstSelectedOptions!.forEach((my) {
                  //       print(my.optionName);
                  //   });
                  // });
                  choiceGroupList.forEach((element) {print(element.lstSelectedOptions!.length);});
                  SavedSharePreference().updateToCart(cartData);
                  break;
                }

            }
            print("moooooooooooooooooooooooooooooooo");
          }
          
        }
      }

      choiceGroupList.clear();
    }
  }


// ignore: must_be_immutable
class _MyAppSpace extends StatelessWidget {
  final item;
  _MyAppSpace(this.item);

  head(isUp) {
    return FlexibleSpaceBar(
      title: isUp
          ? Text(
              item.name,
              style: TextStyle(
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : Text(""),
      // title: Text("Arham",style: TextStyle(color: Colors.black),),
      background: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * .35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          // ResturantInfo(resturantProfile: resturantProfile),
          //  _MyAppSpace()
        ],
      ),
    );
  }

  var deltaExtent;
  var t;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        deltaExtent = settings!.maxExtent - settings.minExtent;
        t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0) as double;
        // print(t == 1.0);
        // final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        // const fadeEnd = 1.0;
        // final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
        // print(t);
        return Opacity(
          opacity: 1,
          child: head((t == 1.0)),
        );
      },
    );
  }
}

snackBarAlert(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 600),
  ));
}
