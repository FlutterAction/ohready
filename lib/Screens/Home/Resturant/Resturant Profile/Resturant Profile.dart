import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/API/API_Manager.dart';
import 'dart:math' as math;
import 'package:secure_hops/Components/Components.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:secure_hops/Components/size_config.dart';
import 'package:secure_hops/Modals/Cart/cartModels.dart';
import 'package:secure_hops/Modals/Favorites/favorites_model.dart';
import 'package:secure_hops/Modals/Resturants/ResturantProfile.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Info.dart';
import 'package:secure_hops/Screens/Home/Resturant/Resturant%20Profile/Resturant%20Menu%20List/MenuList.dart';
import 'package:secure_hops/Screens/Home/home.dart';
import 'package:secure_hops/Screens/Order/CartPage.dart';
import 'package:secure_hops/Screens/Order/CheckOut/checkout.dart';
import 'package:secure_hops/Shared%20Preferences/share_preferences.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Home Page/Empty Home/EmptyHome.dart';
import 'Resturant Menu List/Items List/ItemCard.dart';
import 'Resturant Menu List/Items List/ItemsList.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
// import 'package:inview_notifier_list/inview_notifier_list.dart';

late AutoScrollController myController;

class ResturantProfile extends StatefulWidget {
  final dynamic resturantId;
  ResturantProfile({@required this.resturantId});
  @override
  State<ResturantProfile> createState() => _ResturantProfileState();
}

class _ResturantProfileState extends State<ResturantProfile>
    with SingleTickerProviderStateMixin {
  // ResturantProfileModel? resturantFuture;
  ResturantProfileModel? resturantProfile;
  // List<Item>? itemList;

// var listenerController;
  @override
  void initState() {
    fetchCartDetails();
    getResProfile();
    // Intitilaize the Controller
    myController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    /// Controller Listener for Screen Pixels
    myController.addListener(() {
      currentPosition = myController.position;
      // print(currentPosition);
      if (currentPosition.pixels > 1525 && currentPosition.pixels < 2000) {
        setState(() {
          controller!.index = 1;
        });
      } else if (currentPosition.pixels > 2000 &&
          currentPosition.pixels < 2500) {
        setState(() {
          controller!.index = 2;
        });
      } else if (currentPosition.pixels >= 2500) {
        setState(() {
          controller!.index = 3;
        });
      } else {
        setState(() {
          controller!.index = 0;
        });
      }
    });
    
    super.initState();
  }

  var cartData;

  fetchCartDetails() async {
    cartData = await SavedSharePreference().getAddToCart();
    setState(() {});
  }

  late ScrollPosition currentPosition;

  getResProfile() async {
      
    APIManager()
        .getResturantProfile(context,
            resturantId: widget.resturantId.toString())
        .then((value) {
      resturantProfile = value;
      if(cartData != null)
      checkCartItems(value.menuList);
      if (resturantProfile != null) 
        if (APIManager.allFavorites['lstRestaurant'].isNotEmpty)
        APIManager.allFavorites['lstRestaurant'].forEach((val) {
          if (resturantProfile!.name == val!.name) {
            isAdded = true;
          }
        });

      resturantProfile!.menuList!.forEach((item) {
        if (item.itemsList!.isNotEmpty) {
          resturantLength++;
        }
      });
      controller = TabController(vsync: this, length: resturantLength);
      setState(() {});
    });
  }

  int resturantLength = 0;
  int selectedIndex = 0;
  TabController? controller;

  var itemsCart = [];

  checkCartItems(List<Menu>? itemsMenuList) {
    itemsCart.clear();
    if (itemsMenuList!.isNotEmpty)
      for (var itemMenu in itemsMenuList) {
        for (var itemCard in itemMenu.itemsList!) {
          itemsCart.add({itemCard.itemCode: []});
        }
      }

    if (itemsCart.isNotEmpty)
      for (var cartItems in cartData['lstItems']) {
        for (var item in itemsCart) {
          var key = item.keys.toList()[0];
          if (cartItems['itemCode'] == key) {
            item[key].add(item);            
            }
          }
        }

        print(itemsCart);
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: onWillPop, 
      child: SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                
                print(itemsCart.contains(13));
              },
            ),
            bottomNavigationBar: resturantProfile == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : freeDeliveryInfo(),
            backgroundColor: kBackgroundColor,
            body: showResturantProfile()),
      ),
    );
  }



  Future<bool> onWillPop()  async{
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);    
    return pushAndRemoveUntil(context, provider.loginResponse == null ? AppHomePage(): MyHomePage()) ?? false;     
  }

  showResturantProfile() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    return resturantProfile == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : CustomScrollView(
            controller: myController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true, snap: false, floating: false,
                leading: customRoutePOP(context, provider.loginResponse == null ? AppHomePage(): MyHomePage()),
                actions: [
                  IconButton(
                      onPressed: () {
                        MyProvider provider =
                            Provider.of<MyProvider>(context, listen: false);
                        if (provider.loginResponse != null) {
                          addOrDeleteFavoritesRestaurant();
                        } else {
                          snackBarAlert("Please! Login First");
                        }
                      },
                      icon: Icon(
                        isAdded
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: kWhiteColor,
                      ))
                ],
                expandedHeight: SizeConfig.screenHeight! * .40,
                // flexibleSpace:head(),
                flexibleSpace: _MyAppSpace(resturantProfile),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                      labelPadding: EdgeInsets.symmetric(horizontal: 0),
                      indicatorPadding: EdgeInsets.zero,
                      controller: controller,
                      onTap: (selectedindex) async {
                        selectedIndex = selectedindex;
                        // print(currentPosition);
                        // await myController.positions
                        // print(currentPosition.pixels);
                        // print(controller!.indexIsChanging);
                        // print(controller!.offset);
                        // print(controller.)

                        await myController.scrollToIndex(
                          selectedIndex,
                          preferPosition: AutoScrollPosition.begin,
                        );

                        // setState(() {});
                      },
                      labelColor: Colors.black,
                      indicatorColor: kPrimaryColor,
                      isScrollable: true,
                      tabs: [
                        for (var names in resturantProfile!.menuList!)
                          if (names.itemsList!.isNotEmpty)
                            Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                child: Tab(
                                  text: names.name.toString(),
                                ))
                      ]),
                ),
                pinned: true,
              ),

              // body of Silver
              ListOfItem(selectedIndex, resturantProfile,
                  itemsCart),
            ],
          );
  }

  /// AppBar
  customAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          customPOP(context),
          Spacer(),
          IconButton(
              onPressed: () {
                MyProvider provider =
                    Provider.of<MyProvider>(context, listen: false);
                if (provider.loginResponse != null) {
                  addOrDeleteFavoritesRestaurant();
                } else {
                  snackBarAlert("Please! Login First");
                }
              },
              icon: Icon(
                isAdded ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: kWhiteColor,
              ))
        ],
      ),
    );
  }

  /// Adding Favorites
  bool isAdded = false;

  /// Add or Delete Favorites
  addOrDeleteFavoritesRestaurant() {
    if (isAdded) {
      removeFavoritesRestaurant();
      snackBarAlert("Removed into Favorites");
      setState(() {
        isAdded = false;
      });
    } else {
      addFavoritesRestaurant();
      snackBarAlert("Added into Favorites");
      setState(() {
        isAdded = true;
      });
    }
  }

  /// SnackBar
  snackBarAlert(text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 600),
    ));
  }

  /// Add to Favorites
  addFavoritesRestaurant() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    APIManager()
        .addFavoritesRestaurant(context,
            email: provider.loginResponse!.user!.email,
            password: provider.loginResponse!.password,
            restaurantCode: widget.resturantId)
        .then((value) {
      getFavoritesItems();
    });
  }

  /// Remove to Favorites
  removeFavoritesRestaurant() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);

    APIManager()
        .removeFavoritesRestaurant(context,
            email: provider.loginResponse!.user!.email,
            password: provider.loginResponse!.password,
            restaurantCode: widget.resturantId)
        .then((value) {
      getFavoritesItems();
    });
  }

  /// Get to Favorites
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

  /// Free Delivery Info
  freeDeliveryInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          // height: 60,
          decoration: BoxDecoration(
            color: Colors.red[100],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.delivery_dining_outlined,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Free Deliver From '),
              Spacer(),
              Text(
                  '${convertPrice(context, resturantProfile!.freeDeliveryAfter)}',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        cartData == null
            ? Container()
            : cartData['lstItems'].isEmpty
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: CartButton(
                        text: 'View Your Cart',
                        count: cartData['lstItems'].length,
                        total: convertPrice(context, cartData['total']),
                        onPressed: () {
                          rootPush(context, CartPage());
                        }),
                  ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// ignore: must_be_immutable
class _MyAppSpace extends StatelessWidget {
  final resturantProfile;
  _MyAppSpace(this.resturantProfile);

  head(isUp) {
    return FlexibleSpaceBar(
      title: isUp
          ? Text(
              resturantProfile.name,
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
                height: SizeConfig.screenHeight! * .22,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(resturantProfile!.banner.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                right: 10,
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
                ),
              ),
            ],
          ),

          ResturantInfo(resturantProfile: resturantProfile),
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

// BODY OF SLIVERLIST
// ignore: must_be_immutable
class ListOfItem extends StatelessWidget {
  final selectedIndex, resturantProfile, cartItem;
  ListOfItem(this.selectedIndex, this.resturantProfile, this.cartItem);

  var listOffSets = [];
var lengthItems = 0 ;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var newitemlist =
              resturantProfile!.menuList![index].itemsList!.toList();

          return Consumer<MyProvider>(
            builder: (context, provider, child) => Container(
              // margin: EdgeInsets.only(top: 0),
              child: AutoScrollTag(
                index: index,
                key: ValueKey(index),
                controller: myController,
                child: newitemlist.isEmpty
                    ? Container()
                    : ListTile(
                        title: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            resturantProfile!.menuList![index].name.toString(),
                            style: customStyle,
                          ),
                        ),
                        subtitle: GridView.builder(
                          // controller: listenerController,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.67,
                            crossAxisCount: 2,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: newitemlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(cartItem[11].keys.toList()[0]);
                            // print(newitemlist[index].itemCode == cartItem[7].keys.toList()[0]);
                            // print("Start${newitemlist[index].itemCode}");
                            // print(cartItem.map((val)=> ( newitemlist[index].itemCode == val.keys.toList()[0]) ? "FOUND" : "NO" ).toList()[0]);
                            // print("End${cartItem[0].keys.toList()[0]}");
                            
                            for (var item in cartItem) {
                              var key = item.keys.toList()[0];
                              if(newitemlist[index].itemCode == key){
                                lengthItems = item[key].length;
                                // return lengthItems;
                                break;
                              }

                              // lengthItems = (newitemlist[index].itemCode == key) ? item[key].length : 0;
                              // print((newitemlist[index].itemCode == key));

                            }

                            return ItemCard(
                              cartItems: lengthItems,
                              item: newitemlist[index],
                              resturantProfile: resturantProfile,
                            );
                          },
                        ),
                      ),

                // },
              ),
            ),
          );
        },
        childCount: resturantProfile!.menuList!.length,
      ),
    );
  }
}
