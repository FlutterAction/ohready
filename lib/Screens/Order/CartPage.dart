import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Cart/Cartitem.dart';
import 'package:secure_hops/Modals/Cart/addToCartModel.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/Empty%20Home/EmptyHome.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Menu%20List/Items%20List/ItemDetailScreens/itemTest.dart';
import 'package:secure_hops/Screens/Order/CheckOut/checkout.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:secure_hops/Components/constants.dart';

import '../../API/API_Manager.dart';
import '../Home/Resturant/Resturant Profile/Resturant Profile.dart';

class CartPage extends StatefulWidget {
  final isRoot;

  CartPage([this.isRoot]);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Price
  double subTotalValue = 0;
  double salesTaxValue = 0;
  double deliveryChargesValue = 0;
  // num totalValue = 0.0;
  //

  int value = 1;
  TextStyle style1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  getPrices() {
    clearPrices();

    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
  }

  clearPrices() {
    subTotalValue = 0;
    salesTaxValue = 0;
    deliveryChargesValue = 0;
    // totalValue = 0;
  }

  var cartData;

  bool isLoaded = false;

  AddToCartModel? allItems;

  fetchAllCart() async {
    setState(() {
      isLoaded = true;
    });
    cartData = await SavedSharePreference().getAddToCart();
    // log(jsonEncode(cartData));

    if (cartData != null) {
      allItems = AddToCartModel.fromJson(cartData);
      // totalValue =  allItems!.total + allItems!.shippingCharges;

      // allItems!.lstItems!.forEach((priceGet) {
      // });

      // cartData['lstItems'].forEach((item) {
      //   print(item['name']);
      //   var dataModel = AddToCartModel.fromJson(jsonDecode(json.encode(item)));
      //   // if (dataModel.price != null) {
      //   //   subTotalValue += dataModel.price;
      //   // }
      //   // allItems.add(dataModel);

      //   // totalValue = subTotalValue + deliveryChargesValue + salesTaxValue;
      //   // totalValue = dataModel.price * dataModel.qnty;
      // });
    }
    setState(() {
      isLoaded = false;
    });
    print(isLoaded);

    // print(cartData);
  }

  @override
  void initState() {
    super.initState();
    fetchAllCart();
  }

  List<LstOption> allOptions = [];

  // AddToCartModel? _addToCartModel;
  var j;

  @override
  Widget build(BuildContext context) {
    // getPrices();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // print(cartData);
          SavedSharePreference().clearShareprefrence();

          print("CLEARED.............${allItems!.total}");
          // print(await SavedSharePreference().getAddToCart());
        },
      ),
      backgroundColor: kBackgroundColor,
      bottomNavigationBar:
          cartData == null ? Container(height: 0) : bottomNavigation(),
      appBar: myAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Consumer<MyProvider>(builder: (context, provider, child) {
          return isLoaded
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : cartData == null
                  ? Center(
                      child: Text("No Item Added"),
                    )
                  : Container(
                      child: allItems!.lstItems!.isEmpty
                          ? Center(child: Text("No Item Added"))
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: allItems!.lstItems!.length,
                                      itemBuilder: (context, i) {
                                        // var optionsList = j.lstOptions!;
                                        // print(optionsList.length);
                                        return InkWell(
                                          onTap: () async {
                                            // print(allItems!.lstItems![i]);
                                            ResturantProfileModel
                                                resturantProfile =
                                                await getRestaurantProfile(
                                                    allItems!.restaurantCode);

                                            push(
                                                context,
                                                ItemTest(
                                                  item: allItems!.lstItems![i],
                                                  resturantProfile:
                                                      resturantProfile,
                                                  cartItem:
                                                      allItems!.lstItems![i],
                                                  // variations:{"variationCode":allItems!.lstItems![i],}
                                                ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black38)),
                                            child: Column(
                                              children: [
                                                Card(
                                                  child: Container(
                                                    margin: EdgeInsets.all(5),
                                                    height: 120,
                                                    width: size.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 0.25,
                                                          height:
                                                              size.width * 0.25,
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    allItems!
                                                                        .lstItems![
                                                                            i]
                                                                        .image!),
                                                                fit: BoxFit
                                                                    .fill),
                                                            color:
                                                                Colors.red[100],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 3,
                                                                  horizontal:
                                                                      5),
                                                          height: 80,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          width:
                                                              size.width * 0.40,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${allItems!.lstItems![i].name}",
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              Text(
                                                                  "${allItems!.lstItems![i].qnty} X ${convertPrice(context, allItems!.lstItems![i].rowTotal)}"),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 80,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        0.20,
                                                                height: 35,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFFEEF3FC),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Row(
                                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (allItems!.lstItems![i].qnty <
                                                                            2) {
                                                                          allItems!.total -= allItems!.lstItems![i].rowTotal;
                                                                          allItems!
                                                                              .lstItems!
                                                                              .removeAt(i);
                                                                          if (allItems!
                                                                              .lstItems!
                                                                              .isEmpty) {
                                                                            allItems =
                                                                                null;
                                                                            fetchAllCart();
                                                                          }
                                                                          setState(
                                                                              () {});
                                                                        } else {
                                                                          allItems!
                                                                              .lstItems![i]
                                                                              .qnty = allItems!.lstItems![i].qnty - 1;
                                                                          // allItems!.total -= allItems!.lstItems![i].price;
                                                                          allItems!.total -= allItems!
                                                                              .lstItems![i]
                                                                              .rowTotal;
                                                                          setState(
                                                                              () {});
                                                                        }
                                                                        SavedSharePreference()
                                                                            .updateToCart(allItems);
                                                                        // allItems!.lstItems![i].qnty = allItems!.lstItems![i].qnty - 1;
                                                                        //  allItems!.lstItems![i].price = allItems!.lstItems![i].price * allItems!.lstItems![i].qnty;
                                                                        //  SavedSharePreference().updateToCart(allItems!.lstItems![i]);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            35,
                                                                        width:
                                                                            20,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: FaIcon(
                                                                            FontAwesomeIcons
                                                                                .minus,
                                                                            size:
                                                                                10),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        '${allItems!.lstItems![i].qnty}'),
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .red,
                                                                      onTap:
                                                                          () async {
                                                                        // print(allItems!.lstItems![i].qnty);

                                                                        allItems!
                                                                            .lstItems![
                                                                                i]
                                                                            .qnty = allItems!
                                                                                .lstItems![i].qnty +
                                                                            1;
                                                                        //  allItems!.total += allItems!.lstItems![i].price;
                                                                        allItems!.total += allItems!
                                                                            .lstItems![i]
                                                                            .rowTotal;
                                                                        setState(
                                                                            () {});
                                                                        SavedSharePreference()
                                                                            .updateToCart(allItems);
                                                                        //  allItems!.lstItems![i].qnty
                                                                        //   print(cartData['lsItems']);
                                                                        //  allItems!.lstItems![i].price = allItems!.lstItems![i].price * allItems!.lstItems![i].qnty;
                                                                        //  totalValue += allItems!.lstItems![i].price;
                                                                        //   fetchAllCart();
                                                                        //  cartData = await SavedSharePreference().getAddToCart();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        // color: Colors.red,
                                                                        height:
                                                                            35,
                                                                        width:
                                                                            20,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: FaIcon(
                                                                            FontAwesomeIcons
                                                                                .plus,
                                                                            size:
                                                                                10),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                "${convertPrice(context, allItems!.lstItems![i].rowTotal * allItems!.lstItems![i].qnty)}",
                                                                style: TextStyle(
                                                                    color:
                                                                        primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (allItems!.lstItems![i]
                                                              .selectedVariationName !=
                                                          null)
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text(
                                                                "+",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Text(allItems!
                                                                .lstItems![i]
                                                                .selectedVariationName!
                                                                .toString()),
                                                          ],
                                                        ),
                                                      // if(_addToCartModel!.lstChoiceGroups!.isNotEmpty)
                                                      for (var choiceGroups
                                                          in allItems!
                                                              .lstItems![i]
                                                              .lstChoiceGroups!)
                                                        Container(
                                                          width: size.width,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "+",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              // width: size.width*0.90,
                                                              Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    for (var options
                                                                        in choiceGroups
                                                                            .lstOptions!)
                                                                      Text(
                                                                          "${options.optionName},"),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                    );
        }),
      ),
    );
  }

  getRestaurantProfile(resturantId) async {
    return await APIManager()
        .getResturantProfile(context, resturantId: resturantId.toString());
  }

  myAppBar() {
    return AppBar(
      iconTheme: IconThemeData.fallback(),
      elevation: 1,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: kPrimaryColor,
        ),
        onPressed: () {
          if (widget.isRoot == null) {
            if(allItems == null){
              pop(context);
            }
            else{
              push(context, ResturantProfile(resturantId: allItems!.restaurantCode));
            }
            

          } else {
            setState(() {
              // pop(context);
              screenIndex = 0;
              MyProvider provider =
                  Provider.of<MyProvider>(context, listen: false);
              push(
                  context,
                  (provider.loginResponse != null)
                      ? MyHomePage()
                      : AppHomePage());
            });
          }
        },
      ),
      title: Text(
        'My Cart',
        style: TextStyle(color: appBarText),
      ),
    );
  }

  subTotal() {
    return Row(
      children: [
        Text('Subtotal', style: style1),
        Spacer(),
        Text('${convertPrice(context, subTotalValue)}', style: style1),
      ],
    );
  }

  salesTax() {
    return Row(
      children: [
        Text('Sales Tax', style: style1),
        Spacer(),
        Text('${convertPrice(context, salesTaxValue)}', style: style1),
      ],
    );
  }

  deliveryCharges() {
    return Row(
      children: [
        Text('Deliver Charges', style: style1),
        Spacer(),
        Text('${convertPrice(context, allItems!.shippingCharges)}',
            style: style1),
      ],
    );
  }

  total() {
    return Row(
      children: [
        Text('Total', style: style1),
        Spacer(),
        Text(
            '${convertPrice(context, allItems!.total + allItems!.shippingCharges)}',
            style: style1),
      ],
    );
  }

  bottomNavigation() {
    return Container(
      alignment: Alignment.bottomCenter,
      color: kWhiteColor,
      height: getProportionateScreenHeight(150),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            //
            // SizedBox(
            //   height: 10,
            // ),
            // subTotal(),
            // //
            // SizedBox(
            //   height: 10,
            // ),
            // salesTax(),
            // SizedBox(
            //   height: 10,
            // ),
            //
            deliveryCharges(),
            //
            SizedBox(
              height: 10,
            ),
            //
            total(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: MyButton(
                  text: 'CHECKOUT',
                  onPressed: () {
                    rootPush(context, Checkout());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${item.item!.name}",
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Text(
              '${convertPrice(context, item.variation!.price!)}',
              style: TextStyle(color: textColor),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        for (var option in item.options!)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('+ ${option.name}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '${convertPrice(context, option.price)}',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

// Container(
//                         height: 35,
//                         decoration: BoxDecoration(
//                             color: Color(0xFFEEF3FC),
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   // setState(() {
//                                   //   if (value > 0) {
//                                   //     value--;
//                                   //   }
//                                   // });
//                                 },
//                                 icon: FaIcon(FontAwesomeIcons.minus, size: 10)),
//                             Text('0'),
//                             IconButton(
//                                 onPressed: () {
//                                   // setState(() {
//                                   //   value++;
//                                   // });
//                                 },
//                                 icon: FaIcon(Icons.add, size: 16)),
//                           ],
//                         ),
//                       )
